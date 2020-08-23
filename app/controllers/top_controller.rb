class TopController < ApplicationController
  before_action :set_search
  def index
    @products = Product.includes(:images).where(status: 0).order('created_at DESC')
    @search = Product.ransack(params[:q])
    @search_products = @search.result.page(params[:page]).where(status: 0).order('created_at DESC').page(params[:page]).per(24)
  end
end

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

def search
  if params[:q].present?
  # 検索フォームからアクセスした時の処理
    @search = Product.ransack(search_params)
    @products = @search.result
  else
  # 検索フォーム以外からアクセスした時の処理
    params[:q] = { sorts: 'id desc' }
    @search = Product.ransack()
    @products = Product.all
  end
end