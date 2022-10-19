class AddColumnToDetailItems < ActiveRecord::Migration[6.1]
  def change
    add_column :detail_items, :income_or_payment, :integer, null: false, unsigned: false
  end
end
