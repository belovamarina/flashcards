class NotificationsMailer < ApplicationMailer
  default from: 'appd0d53972250046c9a9b5479e8bc7ffab.mailgun.org'

  def pending_cards(user)
    @cards = user.current_deck ? user.current_deck.cards.needed_to_review : user.cards.needed_to_review

    mail(to: user.email, subject: "Your cards needed to review, #{user.email}")
  end
end
