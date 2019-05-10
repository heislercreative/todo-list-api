class ApplicationController < ActionController::API
  include ::ActionController::Cookies
  include ActionController::Helpers

  HMAC_SECRET = Rails.application.secrets.secret_key_base.to_s

  def login(user)
    payload = {id: user.id}
    token = JWT.encode payload, HMAC_SECRET, 'HS256'
    cookies.signed[:jwt] = {value: token, httponly: true, expires: 2.days.from_now}
  end

  def authenticate_user
    if token = cookies.signed[:jwt]
      body = JWT.decode(token, HMAC_SECRET, true, { algorithm: 'HS256' })
    else
      render json: {error: 'Unauthorized'}, status: 401
    end
  end

  def logged_in_user
    @logged_in_user ||= User.find_by(id: token_user_id) if authenticate_user
  end

  def login_error
    render json: {
        error: 'Username or password incorrect'
      }, status: 400
  end

  helper_method :login
  helper_method :authenticate_user
  helper_method :logged_in_user
  helper_method :login_error

  private

  def token_user_id
    authenticate_user
    user_id = authenticate_user[0]['id']
  end
end
