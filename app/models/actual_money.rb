class ActualMoney < ApplicationRecord
  belongs_to :user
  belongs_to :money_place
  validates :date, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.all_save(data_into_moneies)
    ActualMoney.translation do
      data_into_moneies.map do |data_into_money|
        data_into_money.save
      end
    end
      return true
    rescue => e
      return false
  end
end
