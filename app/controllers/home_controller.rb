class HomeController < ApplicationController
  def index
    return unless current_user
    @random_card = current_user.cards.needed_to_review.order('RANDOM()').first
  end
end
