module Api::V1
  class UsersController < ApplicationController

    def show
      @user = User.find(params[:id])
      render json: @user, status: 200
    end

    def create
      @user = User.new(signup_params)
      if @user.save
        render json: @user, status: 201
      else
        render json: @user.errors, status: 422
      end
    end

    def update
      @user = User.find(params[:id])
      @user.update(update_params)
      if @user.save
        render json: @user, status: 200
      else
        render json: @user.errors, status: 422
      end
    end


    private

    def signup_params
      params.require(:user).permit(:email, :password, :first_name, :last_name)
    end

    def update_params
      params.require(:user).permit(:id, :email, :password, :first_name, :last_name)
    end
  end
end
