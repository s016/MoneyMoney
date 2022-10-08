require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "login" do
    it "正常にレスポンスを返すこと" do
      get new_user_session_path
      expect(response).to have_http_status(200)
    end
  end

  describe "sign_up" do
    it "正常にレスポンスを返すこと" do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end
  end

  describe "log_out" do
    it "ログインページに遷移すること" do
      delete destroy_user_session_path
      expect(response).to redirect_to new_user_session_path
    end
  end
end
