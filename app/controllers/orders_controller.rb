class OrdersController < ApplicationController

  include CurrentCart
  before_action :authenticate_user!, :unless => proc {|c| c.devise_controller?}
  before_action :set_cart, only: [:new, :create, :show]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @orders = Order.all
    respond_with(@orders)
  end

  def show
    
  end

  def new
    if @cart.line_items.empty?
      redirect_to root_path, notice: "Your cart is empty , Please select your items before you are checking out ."

    return
    end
      @order = Order.new
  end


  def edit
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.add_line_items_from_cart(@cart)
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order}
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @order.update(order_params)
    respond_with(@order)
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end



end
 