class ChangeActualMoneiesToActualMonies < ActiveRecord::Migration[6.1]
  def change
    rename_table :actual_moneies, :actual_monies
  end
end
