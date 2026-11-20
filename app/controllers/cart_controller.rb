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
end