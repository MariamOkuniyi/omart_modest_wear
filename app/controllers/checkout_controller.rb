
class CheckoutController < ApplicationController
  before_action :authenticate_user!

  TAX_RATES = {
    "AB" => 0.05, "BC" => 0.12, "MB" => 0.12,
    "NB" => 0.15, "NL" => 0.15, "NT" => 0.05,
    "NS" => 0.14, "NU" => 0.05, "ON" => 0.13,
    "PE" => 0.15, "QC" => 0.14975, "SK" => 0.11,
    "YT" => 0.05
  }.freeze

  def new
  @order = current_user.orders.build
end

  def create
    @order = current_user.orders.build(order_params)
    cart = session[:cart] || {}

    if cart.empty?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    unless TAX_RATES.key?(@order.province)
      @order.errors.add(:province, "is invalid")
      render :new, status: :unprocessable_entity
      return
    end

    products = Product.where(id: cart.keys).index_by { |p| p.id.to_s }

    if products.size != cart.size || cart.any? { |id, qty|
         !qty.to_s.match?(/\A[1-9]\d*\z/) ||
         qty.to_i > products[id]&.stock_quantity.to_i
       }
      redirect_to cart_path, alert: "Some cart items are unavailable."
      return
    end

    subtotal = cart.sum do |id, qty|
      products[id].price * qty.to_i
    end

    @order.subtotal = subtotal.round(2)
    @order.tax = (subtotal * TAX_RATES[@order.province]).round(2)
    @order.total = @order.subtotal + @order.tax
    @order.status = "placed"

    begin
      Order.transaction do
        @order.save!

        cart.each do |id, qty|
          product = products[id]

          @order.order_items.create!(
            product: product,
            quantity: qty.to_i,
            unit_price: product.price
          )
        end
      end

      session.delete(:cart)
      redirect_to order_path(@order), notice: "Order placed successfully!"
    rescue ActiveRecord::RecordInvalid => e
      @order.errors.add(:base, e.record.errors.full_messages.join(", ")) if e.record != @order
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :full_name, :email, :street_address,
      :city, :province, :postal_code
    )
  end
end
