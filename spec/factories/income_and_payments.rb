FactoryBot.define do
  factory :income_and_payment do
    user
    item
    detail_item
    money_place
    date { Date.today }
    month_loop { true }
    amount { 100 }
    type { 1 }
  end
end
