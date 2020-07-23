class CardsController < ApplicationController

  require "payjp"
  before_action :set_card

  def index
    #カードが存在（登録）しているかどうか確認し、あればPAY.JPからカード情報にアクセスして取得
    if @card.present?
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY'] # PAY.JPから情報を取得する際はこの秘密鍵をセットしないと情報にアクセスできない
      customer = Payjp::Customer.retrieve(@card.payjp_id)#PAY.JPに登録されているカード情報のidに紐づく＠cardを探してる
      @card_info = customer.cards.retrieve(customer.default_card)# PAY.JPの顧客情報からデフォルトで使うクレジットカードを取得する。
      #クレジットカード情報から表示させたい情報を定義する。
      #PAY.JPの中にオブジェクト(支払い、顧客、カードなど）があり、さらにそれに対応する値がキーバリュー形式で保存されている。
      #.brandや.last4といったようにドットでつなげることで、ほしいバリューを取得できる
      @card_brand = @card_info.brand #クレジットカードの画像を表示するためにカード会社を取得
      @exp_month = @card_info.exp_month.to_s #カードの有効期限を取得
      @exp_year = @card_info.exp_year.to_s.slice(2,3) # 年は最後の下2桁をsliceメソッドを使って取り出す

      # この後各カード会社のimageをそれぞれファイルに突っ込んで、そのファイルを変数に代入するコードを書く
      # カード会社の画像をviewに表示させるためファイルを指定する
      case  @card_brand
      when "Visa"
        @card_image = "visa.svg"
      when "JCB"
        @card_image = "jcb.svg"
      when "MasterCard"
        @card_image = "master_card.svg"
      when "American Express"
        @card_image = "american_express.svg"
      when "Diners Club"
        @card_image = "diners_club"
      when "Discover"
        @card_image = "discover.svg"
      end
    end
  end



  def new # 支払い方法をクリックするとnewに飛ぶ。newのweb上に追加ボタンがあってそれを押すとcreateへ飛ぶ
    card = Credit_card.where(user_id:current_user.id).first
      redirect_to action: "index" if @card.present? 
  end

  def create
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']# 秘密鍵
  
    if params['payjp-token'].blank? # blankだったらもう一度newで登録画面へ
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create( # トークンがあればpayjpにトークンと顧客情報を結びつける処理（定型文）
      description:'test', # PAY.JPの顧客情報に表示する概要になるらしい。なくても良い
      email: current_user.email,# ログイン中のユーザーのemailをキーにセット
      card: params['payjp-token'], # 直前のnewアクションで発行され送られてくるトークンをcardにセット
      metadata: {user_id:current_user.id}
    )# これでPAY.JPのユーザー登録が完了した。
    @card = Credit_card.new(user_id: current_user.id, customer_id: customer.id,card_id: customer.default_card) #DBに顧客情報を登録
    if @card.save #保存に成功したら
      redirect_to action: "index", notice:"支払い情報の登録が完了しました" #indexに戻る
    else #失敗したら
      render new #newに戻る 
    end
  end

  def destroy
    # クレジットカードを削除するときはPAY.JPの顧客情報ごと削除する。PAY.JPに情報が残ったままだとcreateアクションで不具合が起きるかもしれない
    # PAY.JPの情報にアクセスするときは必ず秘密鍵をセットする！これはもうおまじないのように唱えよう
    Payjp api_key = ENV["PAYJP_PRIVATE_KEY"]
    # PAY.JPの情報を取得するおまじない
    customer = Payjp::Customer.retrieve(@card.payjp_id)
    customer.delete #PAY.JPの顧客情報を削除
    if @card.destroy #アプリ上でもクレジットカードを削除
      redirect_to action: "index", notice: "削除しました"
      else
        redirect_to action: "index", alert: "削除できませんでした"
      end
    end
  end


  private
  def set_card 
    @card = Credit_card.where(user_id: current_user.id).first if Credit_card.where(user_id: current_user.id).present?
  end
end
  