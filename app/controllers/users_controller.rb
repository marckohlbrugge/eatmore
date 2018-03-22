class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by! username: params[:id]
    @meals = @user.meals
    render plain: "Not yet."
  end
end
