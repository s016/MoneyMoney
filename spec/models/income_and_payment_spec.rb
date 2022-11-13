require 'rails_helper'

RSpec.describe IncomeAndPayment, income_or_payment: :model do
  let!(:money_place) { create(:money_place, :oldest_date) }
  let(:income_and_payment) { build(:income_and_payment, money_place_id: money_place.id) }

  it "空白の日付は無効であること" do
    income_and_payment[:date] = nil
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
  it "収入と支払の日付は登録してあるお金の場所より前の日付は無効であること" do
    income_and_payment[:date] = Date.new(2022,10,31)
    income_and_payment.valid?
    expect(income_and_payment.errors[:date]).to include("お金の場所に登録した日付より前の日付は登録できません。")
  end
  it "収入と支払の日付は登録してあるお金の場所より後の日付は有効であること" do
    income_and_payment[:date] = Date.new(2022,11,01)
    income_and_payment.valid?
    expect(income_and_payment).to be_valid
  end
end
