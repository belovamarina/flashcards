module RandomCard
  extend ActiveSupport::Concern

  def set_random_card
    return unless current_user
    @random_card = if deck = current_user.current_deck
                     deck.cards.needed_to_review.order('RANDOM()').first
                   else
                     current_user.cards.needed_to_review.order('RANDOM()').first
                   end
  end
end
