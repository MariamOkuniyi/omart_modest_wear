class CartController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @products = Product.where(id: @cart.keys)
  end

  def add
    product = Product.find(params[:product_id])

    session[:cart] ||= {}
    product_id = product.id.to_s

    session[:cart][product_id] =
      session[:cart].fetch(product_id, 0).to_i + 1

    redirect_to cart_path, notice: "#{product.name} added to cart!"
  end

    # Update the quantity of a product in the shopping cart.
  def update
    product = Product.find(params[:product_id])
    product_id = product.id.to_s
    quantity = params[:quantity].to_i

    session[:cart] ||= {}

    if quantity <= 0
      session[:cart].delete(product_id)
      redirect_to cart_path, notice: "#{product.name} removed from cart."
    elsif quantity > product.stock_quantity
      redirect_to cart_path, alert: "Only #{product.stock_quantity} items available."
    else
      session[:cart][product_id] = quantity
      redirect_to cart_path, notice: "Cart updated successfully!"
    end
  end

  # Remove a product completely from the shopping cart.
  def remove
    product = Product.find(params[:product_id])

    session[:cart] ||= {}
    session[:cart].delete(product.id.to_s)

    redirect_to cart_path, notice: "#{product.name} removed from cart."
  end
end