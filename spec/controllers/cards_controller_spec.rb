require 'rails_helper'
describe CardsController do
    describe 'GET #new' do
      it "new.html.hamlに遷移すること" do
        user = create(:user)
        sign_in user
        get :new
        expect(response).to render_template :new
      end
    end  
end