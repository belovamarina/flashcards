class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy
  accepts_nested_attributes_for :user

  def current?
    user.current_deck == self
  end
end
