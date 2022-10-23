require 'rails_helper'

RSpec.describe "IncomeAndPayments", type: :request do
  let(:user) { create(:user) }
  describe "GET /incomes" do
    context "ログインしている場合"
    it "正常にレスポンスを返すこと" do
      sign_in user
      get incomes_income_and_payments_path
      expect(response).to have_http_status(200)
    end
    it "ログインページにリダイレクトすること" do
      get incomes_income_and_payments_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET /payments" do
    context "ログインしている場合"
    it "正常にレスポンスを返すこと" do
      sign_in user
      get payments_income_and_payments_path
      expect(response).to have_http_status(200)
    end
    it "ログインページにリダイレクトすること" do
      get payments_income_and_payments_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET /new" do
    context "ログインしている場合"
    it "正常にレスポンスを返すこと" do
      sign_in user
      get new_income_and_payment_path
      expect(response).to have_http_status(200)
    end
    it "ログインページにリダイレクトすること" do
      get new_income_and_payment_path
      expect(response).to redirect_to new_user_session_path
    end
  end
end
