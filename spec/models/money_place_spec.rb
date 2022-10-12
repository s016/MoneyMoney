require 'rails_helper'

RSpec.describe MoneyPlace, type: :model do
  let(:money_place) { build(:money_place) }
  it "空白の名前は無効であること" do
    money_place[:name] = nil
    expect(money_place).to be_invalid
  end
  it "空白の日付は無効であること" do
    money_place[:date] = nil  
    expect(money_place).to be_invalid
  end
  it "空白の金額は無効であること" do
    money_place[:amount] = nil  
    expect(money_place).to be_invalid
  end
  it "０円の金額は有効であること" do
    money_place[:amount] = 0
    expect(money_place).to be_valid    
  end
  it "マイナスの金額は無効であること" do
    money_place[:amount] = -1
    expect(money_place).to be_invalid    
  end
end
