class ActualMoney < ApplicationRecord
  belongs_to :user
  belongs_to :money_place
  validates :date, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :invalid_before_confirm_date
  #確定処理を1度もしていない場合0を確定した日付とする。
  NONE_CONFIRM_DATE = 0

  def invalid_before_confirm_date
    if self.date.present?
      regi_confirm_date = self.date
      latest_confirm_date =  ActualMoney.where(user_id: self.user.id).present? ? self.user.actual_moneies.maximum(:date) : ActualMoney::NONE_CONFIRM_DATE
      if regi_confirm_date <= latest_confirm_date
        errors.add(:date, "一番最新の確定した日付は#{latest_confirm_date}です。#{latest_confirm_date}で確定してください。")
      end
    end
  end

  def self.all_save(data_into_moneies)
    ActualMoney.transaction do
      data_into_moneies.map do |data_into_money|
        data_into_money.save!
      end
    end
      return true
    rescue
      return false
  end
end
