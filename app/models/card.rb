class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_uniqueness

  private

  def text_uniqueness
    if self.original_text.strip.downcase == self.translated_text.strip.downcase
      errors.add(:translated_text, 'Текст должен быть разным')
      errors.add(:original_text, 'Текст должен быть разным')
    end
  end
end
