class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards
  after_save :set_noncurrent

  enum status: { noncurrent: 0, current: 1 }

  private

  def set_noncurrent
    return unless status == 'current'
    Deck.where(user_id: user.id).where.not(id: id).update_all(status: :noncurrent)
  end
end
