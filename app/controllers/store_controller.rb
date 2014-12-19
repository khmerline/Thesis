class StoreController < ApplicationController
	include CurrentCart

	before_action :set_cart

  def index
  	@products = Product.all
  	@products = Product.order(:title)

  end

  def show
  	@product = Product.find(params[:product_id])
  end
end
