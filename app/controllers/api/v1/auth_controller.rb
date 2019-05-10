module Api::V1
  class AuthController < ApplicationController

    def create
      @user = User.find_by(email: params[:email])
      if @user.authenticate(params[:password])
        login(@user)
        render json: @user, status: 201
      else
        render json: {
            error: 'Username or password incorrect'
          }, status: 400
      end
    end

    def create_fb
      @user = User.find_or_create_by(uid: auth_params[:id]) do |u|
          u.email = auth_params['email']
          u.first_name = auth_params['first_name']
          u.last_name = auth_params['last_name']
          u.password = SecureRandom.hex(8)
      end
      # @user = User.find_or_create_by(uid: auth[:id]) do |u|
      #   u.email = auth['info']['email']
      #   u.first_name = auth['info']['first_name']
      #   u.last_name = auth['info']['last_name']
      #   u.password = SecureRandom.hex(8)
      # end
      if @user
        login(@user)
        session[:user_id] = @user.id
        render json: @user, status: 201
      end
    end

    def destroy
      cookies.delete(:jwt)
      session[:user_id] = '' if session[:user_id]
    end


    private
    def auth_params
      params.permit(:email, :first_name, :last_name, :id)
    end

    def auth
      request.env['omniauth.auth']
    end
  end
end
