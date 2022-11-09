FactoryBot.define do
  factory :money_place do
    user
    trait :oldest_date do
      name { "oldest_date_money_place" }
      date { Date.new(2022,11,1) }
      amount { 100 }
    end

    trait :latest_date do
      name { "latest_datetest_money_place" }
      date { Date.new(2022,12,1) }
      amount { 500 }
    end
  end
end
