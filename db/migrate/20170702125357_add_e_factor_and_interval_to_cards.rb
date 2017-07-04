class AddEFactorAndIntervalToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :e_factor, :decimal, precision: 6, scale: 2, null: false, default: 2.5
    add_column :cards, :interval, :integer, null: false, default: 0
  end
end
