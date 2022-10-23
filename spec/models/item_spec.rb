require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { build(:item) }
  it "空白の名前は無効であること" do
    item[:name] = nil
    expect(item).to be_invalid
  end
  it "収支の空白は無効であること" do
    item[:income_or_payment] = nil
    expect(item).to be_invalid
  end
  it "収支は1より小さい数値は無効であること" do
    item[:income_or_payment] = 0
    expect(item).to be_invalid
  end
  it "収支は2より大きい数値は無効であること" do
    item[:income_or_payment] = 3
    expect(item).to be_invalid
  end
  it "収支が1の場合有効であること" do
    item[:income_or_payment] = 1
    expect(item).to be_valid
  end
  it "収支が2の場合有効であること" do
    item[:income_or_payment] = 2
    expect(item).to be_valid
  end
end
