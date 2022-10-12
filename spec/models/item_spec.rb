require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { build(:item) }
  it "空白の名前は無効であること" do
    item[:name] = nil
    expect(item).to be_invalid
  end
end
