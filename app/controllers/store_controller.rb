class StoreController < ApplicationController
  def index
    @categories = Category.order(:name)
    @products = Product.includes(:category).order(created_at: :desc)

    if params[:search].present?
      keyword = "%#{Product.sanitize_sql_like(params[:search])}%"
      @products = @products.where(
        "products.name LIKE :keyword OR products.description LIKE :keyword",
        keyword: keyword
      )
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end
  end
end