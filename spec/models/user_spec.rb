require 'rails_helper'

RSpec.describe User, type: :model do
  it "空白の名前は無効であること" do
    user = User.new(name: nil)
    expect(user).to be_invalid  
  end

  it "30文字を超える名前は無効であること" do
    user = User.new(name: "a" * 31)
    expect(user).to be_invalid
  end

  it "空白のメールアドレスは無効であること" do
    user = User.new(email: nil)
    expect(user).to be_invalid
  end

  it "5文字以下のパスワードは無効であること" do
    user = User.new(password: "a" * 5)
    expect(user).to be_invalid
  end

end
