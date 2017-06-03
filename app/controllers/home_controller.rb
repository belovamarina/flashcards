class HomeController < ApplicationController
  def index
    if current_user
      @random_card = current_user.cards.needed_to_review.order('RANDOM()').first
    end
  end
end
