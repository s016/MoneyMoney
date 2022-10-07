require 'rails_helper'

RSpec.describe "Pages", type: :request do
  let(:user) { create(:user) }
  describe "GET /main_page" do
    context "ログインしていないユーザーの場合" do
      it "ログイン画面へリダイレクトすること" do
        get root_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしているユーザーの場合" do
      it "正常にレスポンスを返すこと" do
        sign_in user
        get root_path
        expect(response).to have_http_status(200)
      end
    end
  end
end
