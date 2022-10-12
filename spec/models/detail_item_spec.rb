require 'rails_helper'

RSpec.describe DetailItem, type: :model do
  let(:detail_item) {build(:detail_item)}
  it "空白の名前は無効であること" do
    detail_item[:name] = nil
    expect(detail_item).to be_invalid
  end
end
