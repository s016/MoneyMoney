class DetailItem < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates :name, presence: true
end
