class CreateMoneyPlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :money_places do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.date :date, null: false
      t.integer :amount, null: false, unsigned: false
      t.timestamps
    end
  end
end
