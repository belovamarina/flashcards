class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :email, presence: { message: "Поле %{attribute} должно быть заполнено." }
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/, message: "%{value} -- неправильный формат email"

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  has_many :cards, dependent: :destroy
end
