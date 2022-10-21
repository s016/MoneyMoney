class IncomeAndPayment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :detail_item
  belongs_to :money_place
  validates :date, presence: true
  validates :month_loop, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :income_or_payment, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2 }
  INCOMES = 1
  PAYMENTS = 2
end
