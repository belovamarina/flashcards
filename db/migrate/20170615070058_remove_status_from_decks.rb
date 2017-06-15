class RemoveStatusFromDecks < ActiveRecord::Migration[5.0]
  def change
    remove_column :decks, :status
  end
end
