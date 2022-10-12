class DetailItem < ApplicationRecord
  has_many :income_and_payments
  belongs_to :user
  belongs_to :item
  validates :name, presence: true
end
