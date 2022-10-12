require 'rails_helper'

RSpec.describe DetailItem, type: :model do
  let(:item) {create(:item)}
  it "空白の名前は無効であること" do
    detail_item = item.detail_items.create(name: nil)
    expect(detail_item).to be_invalid
  end
end
