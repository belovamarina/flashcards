class NotificationsMailer < ApplicationMailer
  default from: 'rubyonrails4@ya.ru'

  def pending_cards(user)
    @cards = user.current_deck ? user.current_deck.cards.needed_to_review : user.cards.needed_to_review

    mail(to: user.email, subject: "Your cards needed to review, #{user.email}")
  end
end
