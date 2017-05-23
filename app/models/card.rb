class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_uniqueness

  scope :needed_to_review,  -> { where('review_date <= ?', Date.today) }


  def correct_translate?(word)
    word.strip.downcase == original_text.strip.downcase
  end

  private

  def text_uniqueness
    if original_text.strip.downcase == translated_text.strip.downcase
      errors.add(:translated_text, 'Текст должен быть разным')
      errors.add(:original_text, 'Текст должен быть разным')
    end
  end
end
