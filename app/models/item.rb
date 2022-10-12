class Item < ApplicationRecord
  has_many :detail_items
  belongs_to :user
  validates :name, presence: true
end
