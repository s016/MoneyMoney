class RenameTypeCulumnToIncomeAndPayments < ActiveRecord::Migration[6.1]
  def change
    rename_column :income_and_payments, :type, :income_or_payment_type 
  end
end
