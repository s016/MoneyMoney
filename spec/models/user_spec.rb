require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前が空白でないこと" do
    user = User.new(name: nil)
    expect(user).to be_invalid  
  end

  it "30文字以下の名前であること" do
    user = User.new(name: "a" * 31)
    expect(user).to be_invalid
  end

  it "メールアドレスは空白でないこと" do
    user = User.new(email: nil)
    expect(user).to be_invalid
  end

  it "5文字以下のパスワードは無効であること" do
    user = User.new(password: "a" * 5)
    expect(user).to be_invalid
  end

end
