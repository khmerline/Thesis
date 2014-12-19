class LineItemsController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @line_items = LineItem.all
    respond_with(@line_items)
  end

  def show
    respond_with(@line_item)
  end

  def new
    @line_item = LineItem.new
    respond_with(@line_item)
  end

  def edit
  end

  def create
    product = Product.find(params[:product_id])

    @line_item = @cart.add_product(product.id)
    respond_to do |format|
    if @line_item.save
      format.html { redirect_to root_path }

      format.json { render action: 'show',
      status: :created, location: @line_item }
      format.js

    else
      format.html { render action: 'new' }
      format.json { render json: @line_item.errors,
      status: :unprocessable_entity }

    end
  end

  end

  def update
    @line_item.update(line_item_params)
    respond_with(@line_item)
  end

  def destroy
    @line_item.destroy
    
    respond_to do |format|
     format.html { redirect_to root_path }
    end 

  end

  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:product_id)

    end
end
