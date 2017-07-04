class RemoveFailReviewsFromCards < ActiveRecord::Migration[5.0]
  def change
    remove_column :cards, :fail_reviews, :integer
  end
end
