class CardsController < ApplicationController

  require "payjp"
  before_action :set_card

  def index
    #カードが存在（登録）しているかどうか確認し、あればPAY.JPからカード情報にアクセスして取得
    if @card.present?
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]# PAY.JPから情報を取得する際はこの秘密鍵をセットしないと情報にアクセスできない
      customer = Payjp::Customer.retrieve(@card.customer_id)#PAY.JPに登録されている顧客情報のidに紐づく＠cardを探してる
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
          @card_image = "visa_card.svg"
        when "JCB"
          @card_image = "jcb.svg"
        when "MasterCard"
          @card_image = "master_card.svg"
        when "American Express"
          @card_image = "american_express.svg"
        when "Diners Club"
          @card_image = "diners.svg"
        when "Discover"
          @card_image = "discover.svg"
      end
    end
  end



  def new # 支払い方法をクリックするとnewに飛ぶ。newのweb上に追加ボタンがあってそれを押すとcreateへ飛ぶ
    card = CreditCard.where(user_id:current_user.id).first
      redirect_to action: "index" if @card.present? # カード情報があればindexに飛ぶ（削除もできる画面）
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY] # 秘密鍵。PAY.JPと通信（保存したり、抽出したり）するときはこの秘密鍵が必要。
     #binding.pry
    if params['payjp-token'].blank? # トークンがなければもう一度newで登録画面へ
      redirect_to action: "new"
    else
      # PAY.JPのメソッドを用いてc顧客idを生成、取得している
      customer = Payjp::Customer.create( 
      email: current_user.email,# ログイン中のユーザーのemailをキーにセット
      card: params['payjp-token'], # 直前のnewアクションで発行され送られてくるトークンをcardにセット
      metadata: {user_id:current_user.id}
      )# この()内でPAY.JPのユーザー登録が完了した。
    end
    # これより下は自分のDBに値を保存する処理
    @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id,card_id: customer.default_card)
    if @card.save
      redirect_to action: "index", notice:"支払い情報の登録が完了しました" 
    else 
      render new 
    end
  end

  def destroy
    # クレジットカードを削除するときはPAY.JPの顧客情報ごと削除する。PAY.JPに情報が残ったままだとcreateアクションで不具合が起きるかもしれない
    # PAY.JPの情報にアクセスするときは必ず秘密鍵をセットする
    
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    # PAY.JPのメソッドを使って、削除したい顧客情報を検索する
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete #PAY.JPの顧客情報を削除
    if @card.destroy #アプリ上でもクレジットカードを削除
      redirect_to action: "index", notice: "削除しました"
    else
      redirect_to action: "index", notice: "削除できませんでした"
    end
  end


  private
  def set_card 
    @card = CreditCard.where(user_id: current_user.id).first if CreditCard.where(user_id: current_user.id).present?
  end
end
  
