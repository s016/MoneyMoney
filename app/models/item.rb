class Item < ApplicationRecord
  has_many :detail_items
  has_many :income_and_payments
  belongs_to :user
  validates :name, presence: true
end
