class Result < ApplicationRecord

  #計算の対象期間
  def self.result_date
    #お金の場所の登録された一番古い日付を取得、確定処理を実装したら、確定処理から3年間に変更する。
    start_day = MoneyPlace.minimum(:date)
    #3年間計算予定
    end_day = start_day.since(3.month)
    (start_day..end_day).select { |date| date }
  end

  #1ヶ月ごとの日付を配列にして返す
  def self.monthly(income_and_payment)
    if income_and_payment.month_loop == true
      start_day = income_and_payment.date
      end_day = income_and_payment.date.since(36.month)
      (start_day..end_day).select { |date| date.day == income_and_payment.date.day }
    else
      [income_and_payment.date]
    end
  end

  #計算対象の日付がmonthlyの結果にあればその金額を、なければnilを返す
  def self.result_income_and_payment(income_or_payments)
    if income_or_payments.present?
      self.result_date.map do |day|
        [
          day, 
          income_or_payments.map do |income_or_payment|
            self.monthly(income_or_payment).include?(day) ? [income_or_payment.item.name, income_or_payment.amount] : [income_or_payment.item.name, nil]
          end
        ]
      end
    end
  end
end