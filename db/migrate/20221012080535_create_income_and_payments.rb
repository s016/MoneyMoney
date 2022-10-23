class CreateIncomeAndPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :income_and_payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.references :detail_item, null: false, foreign_key: true
      t.references :money_place, null: false, foreign_key: true
      t.date :date, null: false
      t.boolean :month_loop, null: false
      t.integer :amount, null: false, unsigned: false
      t.integer :type, null: false, unsigned: false
      t.timestamps
    end
  end
end
