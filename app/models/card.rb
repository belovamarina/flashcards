class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_uniqueness

  mount_uploader :image, ImageUploader

  belongs_to :deck

  scope :needed_to_review, -> { where('review_date <= ?', Time.now) }

  INTERVALS = { 0 => 0.hours,
                1 => 12.hours,
                2 => 3.days,
                3 => 7.days,
                4 => 14.days,
                5 => 1.month }.freeze

  def compare(word)
    user_word = word.strip.downcase
    original_word = original_text.strip.downcase
    DamerauLevenshtein.distance(user_word, original_word)
  end

  def success_review
    self.success_reviews += 1 unless success_reviews == INTERVALS.count
    self.fail_reviews = 0
    update(review_date: INTERVALS[success_reviews].from_now)
  end

  def fail_review
    self.fail_reviews += 1

    if (fail_reviews % 3).zero?
      self.success_reviews -= 1 unless success_reviews.zero?
      update(review_date: INTERVALS[success_reviews].from_now)
    else
      update(review_date: Time.now)
    end
  end

  private

  def text_uniqueness
    return unless original_text.strip.casecmp(translated_text.strip).zero?
    errors.add(:translated_text, 'Текст должен быть разным')
    errors.add(:original_text, 'Текст должен быть разным')
  end
end
