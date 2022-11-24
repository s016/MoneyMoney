class Result < ApplicationRecord
  
  #計算の対象期間
  def self.result_date(current_user)
    #お金の場所の登録された一番古い日付を取得、確定処理を実装したら、確定処理から3年間に変更する。
    if current_user.actual_moneies.present?
      start_day = current_user.actual_moneies.maximum(:date)
    else
      start_day = current_user.money_places.minimum(:date)
    end
    #3年後の月末まで
    end_day = start_day.since(3.year).end_of_month
    (start_day..end_day).select { |date| date }
  end

  def self.result_income_and_payment(income_or_payments, income_or_payment_num, current_user)
    if income_or_payments.present?
      result = {}
      self.result_date(current_user).each do |result_date|
        result[result_date.to_s] = {}
        Item.where(income_or_payment: income_or_payment_num).each do |item|
          result[result_date.to_s][item.name] = IncomeAndPayment.where(user_id: current_user.id, item_id: item.id, date: result_date).sum(:amount)
        end
      end
      return result
    end
  end

  def self.result_sum(result_data, date)
    if result_data.present?
        result_data.where(date: date).sum(:amount)
    end
  end

  def self.result_money_place(money_places, current_user)
    if money_places.present?
      result = {}
      self.result_date(current_user).each do |result_date|
        result[result_date.to_s] = {}
        money_places.each do |money_place|
          start_day = current_user.actual_moneies.present? ? current_user.actual_moneies.maximum(:date) : money_place.date
          end_day = start_day.since(3.year).end_of_month
          incomes = IncomeAndPayment.where(money_place_id: money_place.id, date: start_day..end_day, income_or_payment: IncomeAndPayment::INCOMES).sum(:amount)
          payments = IncomeAndPayment.where(money_place_id: money_place.id, date: start_day..end_day, income_or_payment: IncomeAndPayment::PAYMENTS).sum(:amount)
          if money_place.actual_moneies.present?
            result[result_date.to_s][money_place.name] = money_place.actual_moneies.find_by(date: money_place.actual_moneies.maximum(:date)).amount + incomes - payments
          else
            result[result_date.to_s][money_place.name] = money_place.amount + incomes - payments
          end
        end
      end
    end
    return result
  end
end