FactoryBot.define do
  factory :detail_item do
    name { "test_detail_item" }
    user 
    item
    income_or_payment {1} 
  end
end
