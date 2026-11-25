class ProductsController < ApplicationController
  def show
    # Find the product selected by the customer using its ID.
    @product = Product.find(params[:id])
  end
end