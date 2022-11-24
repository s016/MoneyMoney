require 'rails_helper'

RSpec.describe ActualMoney, type: :model do
  let(:actual_money) { build(:actual_money) }

  it "空白の日付は無効であること" do
    actual_money[:date] = nil
    expect(actual_money).to be_invalid  
  end

  it "空白の金額は無効であること" do
    actual_money[:amount] = nil
    expect(actual_money).to be_invalid
  end

  it "0以上の金額は有効であること" do
    actual_money[:amount] = 0
    expect(actual_money).to be_valid
  end

  it "0より小さい金額は無効であること" do
    actual_money[:amount] = -1
    expect(actual_money).to be_invalid
  end
end
