class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by! profile_token: params[:id]
    @meals = @user.meals
  end
end
