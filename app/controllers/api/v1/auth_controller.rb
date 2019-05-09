module Api::V1
  class AuthController < ApplicationController

    def create
      @user = User.find_by(email: params[:email])
      if @user
        hmac_secret = 'c0n$tra!n3d'
        payload = {id: @user.id}
        created_jwt = JWT.encode payload, hmac_secret, 'HS256'
        cookies.signed[:jwt] = {value: created_jwt, httponly: true, expires: 2.days.from_now}
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
