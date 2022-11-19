class IncomeAndPayment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :detail_item
  belongs_to :money_place
  validates :date, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :income_or_payment, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2 }
  validate :invalid_before_money_places_date
  validate :invalid_before_confirm_date
  INCOMES = 1
  PAYMENTS = 2
  THREE_YEAR_TO_MONTH_MINUS_SAVED_MAONTH = 11

  def self.find_money_place_date(money_place_id)
    money_place_date = MoneyPlace.find_by(id: money_place_id).date
  end

  def self.find_income_and_payment_date(income_and_payment_params)
    income_and_payment_date = income_and_payment_params
  end

  def invalid_before_money_places_date
    if self.money_place.date.present? && self.date.present?
      income_and_payment_date = self.date
      money_place_date = self.money_place.date
      if income_and_payment_date < money_place_date
        errors.add(:date, "お金の場所に登録した日付より前の日付は登録できません。")
      end
    end
  end

  def invalid_before_confirm_date
    if self.user.actual_moneies.present? && self.date.present?
      income_and_payment_date = self.date
      confirm_date =  ActualMoney.where(user_id: self.user.id).present? ? self.user.actual_moneies.maximum(:date) : ActualMoney::NONE_CONFIRM_DATE
      if income_and_payment_date <= confirm_date
        errors.add(:date, "確定した日付より前の日付は登録できません。")
      end
    end
  end
 end
