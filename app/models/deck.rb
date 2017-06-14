class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards

  def current?
    user.current_deck_id == id
  end
end
