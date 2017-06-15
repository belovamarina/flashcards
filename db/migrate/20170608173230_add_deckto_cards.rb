class AddDecktoCards < ActiveRecord::Migration[5.0]
  def change
    add_reference :cards, :deck, index: true
  end
end
