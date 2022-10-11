require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user) }
  it "空白の名前は無効であること" do
    user.items.create(name: nil)
    expect(user).to be_invalid
  end
end
