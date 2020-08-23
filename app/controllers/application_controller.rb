class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production? #本番環境のみにBasic認証を適応
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def set_search
    if params[:q] != nil
      params[:q]['title_or_description_cont_any'] = params[:q]['title_or_description_cont_any'].try { |prm| prm.split(/[[:blank:]]/) }
      @search = Product.ransack(params[:q])
      @search_products = @search.result.page(params[:page]).order('status ASC').order('created_at DESC').page(params[:page]).per(12)
    else
      @search = Product.ransack(params[:q])
      @search_products = @search.result.page(params[:page]).order('status ASC').order('created_at DESC').page(params[:page]).per(12)
    end
  end
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
