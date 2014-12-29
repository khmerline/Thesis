class UserController < ApplicationController
  include CurrentCart
	before_action :authenticate_user!, :unless => proc  {|c| c.devise_controller?}
	before_action :set_cart, only: [:new, :create, :show]
  def index
  	@user_profile = current_user
  end
end
