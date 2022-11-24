FactoryBot.define do
  factory :actual_money do
    user
    money_place
    date { Date.new(2022,11,15) }
    amount { 500 }
  end
end
