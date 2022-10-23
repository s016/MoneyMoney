class DetailItem < ApplicationRecord
  has_many :income_and_payments
  belongs_to :user
  belongs_to :item
  validates :name, presence: true
  validates :income_or_payment, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2 }
end
