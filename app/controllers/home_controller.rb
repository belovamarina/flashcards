class HomeController < ApplicationController
  def index
    @random_card = Card.needed_to_review.order('RANDOM()').first
  end
end
