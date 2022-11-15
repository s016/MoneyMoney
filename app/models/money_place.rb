class MoneyPlace < ApplicationRecord
  has_many :income_and_payments
  has_many :actual_moneies
  belongs_to :user
  validates :name, presence: true
  validates :date, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
