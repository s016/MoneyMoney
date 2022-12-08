require 'rails_helper'

RSpec.describe Result, type: :model do
  let(:user) { create(:user) }
  let!(:oldest_date) { create(:money_place, :oldest_date, user: user) }
  let!(:latest_date) { create(:money_place, :latest_date, user: user) }
  
  describe "result_date" do
    it "6ヶ月後の月末を返すこと" do
      expect(Result.result_date(user).last).to eq Date.new(2023,5,31)
    end

    it "日付が古いお金の場所のから計算の対象期間を返していること" do
      expect(Result.result_date(user).first).to eq Date.new(2022,11,1)
    end
  end
end
