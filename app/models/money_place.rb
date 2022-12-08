class MoneyPlace < ApplicationRecord
  has_many :income_and_payments
  has_many :actual_monies
  belongs_to :user
  validates :name, presence: true
  validates :date, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :invalid_before_confirm_date

  def invalid_before_confirm_date
    if self.user.money_places.present? && self.date.present?
      money_place_date = self.date
      confirm_date =  ActualMoney.where(user_id: self.user.id).present? ? self.user.actual_monies.maximum(:date) : ActualMoney::NONE_CONFIRM_DATE
      if money_place_date <= confirm_date
        errors.add(:date, "確定した日付より前の日付は登録できません。")
      end
    end
  end
end