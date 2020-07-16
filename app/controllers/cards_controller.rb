class CardsController < ApplicationController

  require 'payjp'
  before_action :set_card #どのアクションよりも先に実行される

  # ここで登録したクレジットの表示画面を作成、この辺参考になるコードがまだ見つかってない
  def index
  end

  # クレジットカード情報入力画面
  def new
    if @card #@card = Credit＿card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)がtrueであれば
      redirect_to card_path unless @card #redirectで○○アクションのビューに飛ぶ
    else #falseだったら
      render '#' #renderでマイページからカードを作成するビューに飛ぶ
    end
  end

  # 登録画面で入力した情報をDBに保存
  def create
    Payjp.api_key = ENV["PAYJP_ACCESS_KEY"] #秘密鍵
    if params['payjp-token'].blank? #paramsの中にあるpayjp-tokenがblankであれば
      render '#' #マイページでカード作成するビューへ飛ぶ
    else #そうじゃなければ
      customer = Payjp::Customer.create( # ここで先ほど生成したトークンを顧客情報と紐付け、PAY.JP管理サイトに送信
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id} # 記述しなくても良いらしい
      )
      @card = Credit＿card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save #カードの保存に成功したら
        redirect_to "#" #
      else #失敗したら
        render 'mypages/create_card'#マイページのクレジットカード登録画面に飛ぶ
      end
    end
  end

  # 後ほど削除機能を実装、ここはもう最後にやるって決めてる
  def destroy
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end

end
