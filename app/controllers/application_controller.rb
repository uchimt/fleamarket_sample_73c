class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production? #本番環境のみにBasic認証を適応
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  private
#本番環境かどうか確認するメソッド 本番環境ならtrueを返す
  def production?
    Rails.env.production?
  end
#Basic認証 環境変数による導入
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
