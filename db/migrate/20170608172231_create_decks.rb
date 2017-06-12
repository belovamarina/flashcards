class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.string :name
      t.belongs_to :user
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
