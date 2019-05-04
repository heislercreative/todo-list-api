class UsersController < ApplicationController

  def create
    @user = User.new(signup_params)
    if @user.save
      render json: @user, status: 201
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(update_params)
    if @user.save
      render json: @user, status: 201
    end
  end


  private

  def signup_params
    params.permit(:email, :password, :first_name, :last_name)
  end

  def update_params
    params.permit(:id, :email, :password, :first_name, :last_name)
  end
end
