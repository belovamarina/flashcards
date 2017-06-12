class User < ApplicationRecord
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :email, presence: { message: "Поле %{attribute} должно быть заполнено." }
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/, message: "%{value} -- неправильный формат email"

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  has_many :decks, dependent: :destroy
  has_many :cards, through: :decks, dependent: :destroy

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
end
