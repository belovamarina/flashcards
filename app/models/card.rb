class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_uniqueness

  mount_uploader :image, ImageUploader

  belongs_to :deck

  scope :needed_to_review, -> { where('review_date <= ?', Date.today) }

  def correct_translate?(word)
    return unless word.strip.casecmp(original_text.strip).zero?
    update(review_date: 3.days.from_now)
  end

  private

  def text_uniqueness
    return unless original_text.strip.casecmp(translated_text.strip).zero?
    errors.add(:translated_text, 'Текст должен быть разным')
    errors.add(:original_text, 'Текст должен быть разным')
  end
end
