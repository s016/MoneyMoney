FactoryBot.define do
  factory :item do
    user
    name {"test_item"}
    income_or_payment {1}
  end
end
