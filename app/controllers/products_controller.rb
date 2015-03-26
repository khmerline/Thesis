class ProductsController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    cate = params[:id]
    if cate
      @products = Product.of_cate(cate)
      
    end
    @products = Product.order(created_at: :desc)
  end

  def show
   
  end

  def new
    @product = Product.new
    
  end

  def edit
  end

  def create
    @product = Product.create(product_params)

    @product.save
    respond_to do |format|
      if @product.save
        format.js 
        format.html { redirect_to products_path, notice: 'Product was succesfully created.'}
        format.json { render action: 'show', status: :created, location: @product } 
      else
        format.html { render action: 'new'}
        format.json { render json: @product.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: 'Product was succesfully updated.'}
        format.json { head :no_content }
        format.js
      else

        format.html { render action: 'edit'}
        format.json { render json: @product.errors, status: :unprocessable_entity}
      end

    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url}
       format.json { head :no_content }

    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :catagory_id, :read_more)
    end
end
