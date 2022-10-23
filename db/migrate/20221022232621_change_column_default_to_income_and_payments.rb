class ChangeColumnDefaultToIncomeAndPayments < ActiveRecord::Migration[6.1]
  def change
    change_column_default :income_and_payments, :month_loop, false
  end
end
