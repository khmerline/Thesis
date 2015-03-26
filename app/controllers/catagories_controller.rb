class CatagoriesController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_catagory, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @catagories = Catagory.all
    
  end

  def show
    respond_with(@catagory)
  end

  def new
    @catagory = Catagory.new
    respond_with(@catagory)
  end

  def edit
  end

  def create
    @catagory = Catagory.new(catagory_params)
    @catagory.save
    respond_to do |format|

      if @catagory.save
        format.html { redirect_to @catagory, notice: 'Catagory was successfully created.'}
        format.json { render action: 'show', status: :created, location: @catagory}
      else
        format.html { render action: 'new'}
        format.json { render json: @catagory.errors, status: :unprocessable_entity}
      end

    end
  end

  def update
    respond_to do |format|
      if @catagory.update(catagory_params)
        format.json { render json: @catagory.errors, status: :unprocessable_entity}
        format.json { head :no_content }
      else
        format.html { render action: 'edit'}
        format.json { render json: @catagory.errors, status: :unprocessable_entity}
      end

    end
  end

  def destroy
    @catagory.destroy
    respond_to do |format|
      format.html  { redirect_to catagories_url }
      format.json { head :no_content}

    end
  end

  private
    def set_catagory
      @catagory = Catagory.find(params[:id])
    end

    def catagory_params
      params.require(:catagory).permit(:cat_type)
    end
end
