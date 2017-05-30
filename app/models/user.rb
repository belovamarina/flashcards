class User < ApplicationRecord
  validates :email, presence: { message: "Поле %{attribute} должно быть заполнено." }
  validates :password, presence: { message: "Поле %{attribute} должно быть заполнено." }
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/, message: "%{value} -- неправильный формат email"

  has_many :cards
end
