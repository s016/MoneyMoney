class RenameIncomeOrPaymentTypeColumnToIncomeAndPauments < ActiveRecord::Migration[6.1]
  def change
    rename_column :income_and_payments, :income_or_payment_type, :income_or_payment
  end
end
