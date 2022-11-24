class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, length: {maximum:30}, presence: true
  has_many :items
  has_many :detail_items
  has_many :income_and_payments
  has_many :money_places
  has_many :actual_moneies
end
