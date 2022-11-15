class CreateActualMoneies < ActiveRecord::Migration[6.1]
  def change
    create_table :actual_moneies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :money_place, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :amount, null: false, unsigned: false
      t.timestamps
    end
  end
end