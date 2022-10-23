require 'rails_helper'

RSpec.describe "DetailItems", type: :request do
  let(:user) { create(:user) }
  describe "GET /index" do
    context "ログインしている場合"
    it "正常にレスポンスを返すこと" do
      sign_in user
      get detail_items_path
      expect(response).to have_http_status(200)
    end
    it "ログインページにリダイレクトすること" do
      get detail_items_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET /new" do
    context "ログインしている場合"
    it "正常にレスポンスを返すこと" do
      sign_in user
      get new_detail_item_path
      expect(response).to have_http_status(200)
    end
    it "ログインページにリダイレクトすること" do
      get new_detail_item_path
      expect(response).to redirect_to new_user_session_path
    end
  end
end
