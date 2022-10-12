FactoryBot.define do
  factory :money_place do
    user
    name { "test_money_place" }
    date { Date.today }
    amount { 100 }
  end
end
