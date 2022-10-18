require 'rails_helper'

RSpec.describe IncomeAndPayment, income_or_payment: :model do
  let(:income_and_payment) { build(:income_and_payment) }
  it "空白の日付は無効であること" do
    income_and_payment[:date] = nil
    expect(income_and_payment).to be_invalid
  end
  it "毎月の繰り返しの空白は無効であること" do
    income_and_payment[:month_loop] = nil
    expect(income_and_payment).to be_invalid
  end
  it "金額の空白は無効であること" do
    income_and_payment[:amount] = nil
    expect(income_and_payment).to be_invalid
  end
  it "マイナスの金額は無効であること" do
    income_and_payment[:amount] = -1
    expect(income_and_payment).to be_invalid
  end
  it "金額が0以上である場合は有効であること" do
    income_and_payment[:amount] = 0
    expect(income_and_payment).to be_valid
  end
  it "収支タイプの空白は無効であること" do
    income_and_payment[:income_or_payment] = nil
    expect(income_and_payment).to be_invalid
  end
  it "収支タイプの最小値は1であること" do
    income_and_payment[:income_or_payment] = 1
    expect(income_and_payment).to be_valid
  end
  it "収支タイプの最大値は2であること" do
    income_and_payment[:income_or_payment] = 2
    expect(income_and_payment).to be_valid
  end
  it "1と2以外の収支タイプは無効であること" do
    income_and_payment[:income_or_payment] = 3
    expect(income_and_payment).to be_invalid
  end
end
