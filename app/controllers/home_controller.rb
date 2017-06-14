class HomeController < ApplicationController
  def index
    return unless current_user
    @random_card = if Deck.exists?(current_user.current_deck_id)
                     Deck.find(current_user.current_deck_id).cards.needed_to_review.order('RANDOM()').first
                   else
                     current_user.cards.needed_to_review.order('RANDOM()').first
                   end
  end
end
