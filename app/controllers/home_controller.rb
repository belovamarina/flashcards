class HomeController < ApplicationController
  def index
    return unless current_user
    deck = current_user.decks.current.first
    if deck.present?
      @random_card = deck.cards.needed_to_review.order('RANDOM()').first
    else
      @random_card = current_user.cards.needed_to_review.order('RANDOM()').first
    end
  end
end
