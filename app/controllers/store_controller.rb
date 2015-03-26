class StoreController < ApplicationController
	include CurrentCart

	before_action :set_cart

  def index
  	   cate = params[:id]
    	if cate 
      @products = Product.of_cate(cate).paginate(:page => params[:page], :per_page => 12)
    	else
  	@products = Product.order(created_at: :desc).paginate(:page => params[:page], :per_page => 12)
  	end
  	@latest_product = Product.order(created_at: :desc).paginate(:page => params[:page], :per_page => 50)
  	@catagories = Catagory.all
  end

  def show
  	@product = Product.find(params[:product_id])

    
  end
end
