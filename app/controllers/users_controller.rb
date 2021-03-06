class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to orders_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:password, :username)
  end
end