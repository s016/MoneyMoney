require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前が空白でないこと" do
    user = User.new(name: nil)
    expect(user).to be_invalid  
  end

  it "名前は30文字以内であること" do
    user = User.new(name: "a" * 31)
    expect(user).to be_invalid
  end

  it "メールアドレスが空白でないこと" do
    user = User.new(email: nil)
    expect(user).to be_invalid
  end

  it "パスワードは6文字以上であること" do
    user = User.new(password: "a" * 5)
    expect(user).to be_invalid
  end
end
