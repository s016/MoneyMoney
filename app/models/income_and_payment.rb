class IncomeAndPayment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :detail_item
  belongs_to :money_place
  validates :date, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :income_or_payment, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2 }
  validate :invalid_date
  INCOMES = 1
  PAYMENTS = 2
  THREE_YEAR_TO_MONTH_MINUS_SAVED_MAONTH = 35

  def self.find_money_place_date(money_place_id)
    money_place_date = MoneyPlace.find_by(id: money_place_id).date
  end

  def self.find_income_and_payment_date(income_and_payment_params)
    income_and_payment_date = income_and_payment_params
  end

  def invalid_date
    if self.money_place.date && self.date.present?
      income_and_payment_date = self.date
      money_place_date = self.money_place.date
      if income_and_payment_date < money_place_date
        errors.add(:date, "お金の場所に登録した日付より前の日付は登録できません。")
      end
    end
  end
 end
