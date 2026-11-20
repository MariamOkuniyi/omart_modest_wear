class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_user.orders
                         .includes(order_items: :product)
                         .find(params[:id])
  end
end