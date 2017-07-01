class User < ApplicationRecord
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :email, uniqueness: true, presence: { message: "Поле %{attribute} должно быть заполнено." }
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/, message: "%{value} -- неправильный формат email"

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :locale, inclusion: { in: %w(en ru), message: "%{value} is not a valid lang" }

  has_many :decks, dependent: :destroy
  has_many :cards, through: :decks, dependent: :destroy
  belongs_to :current_deck, class_name: 'Deck', foreign_key: :current_deck_id, optional: true

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  def self.notify_about_pending_cards
    users_with_pending_cards.each do |user|
      NotificationsMailer.pending_cards(user).deliver_now
    end
  end

  def self.users_with_pending_cards
    joins(:cards).where('review_date <= ?', Time.now).distinct
  end
end
