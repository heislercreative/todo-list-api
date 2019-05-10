module Api::V1
  class AuthController < ApplicationController

    def create
      @user = User.find_by(email: params[:email])
      if @user
        login(@user)
        render json: @user, status: 201
      else
        render json: {
            error: 'Username or password incorrect'
          }, status: 404
      end
    end

    def destroy
      cookies.delete(:jwt)
    end


    private

    def auth
      request.env['omniauth.auth']
    end
  end
end
