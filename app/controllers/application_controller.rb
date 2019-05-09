class ApplicationController < ActionController::API
  include ::ActionController::Cookies

  def authenticate_user
    jwt = cookies.signed[:jwt]
    decode_jwt(jwt)
  end
end
