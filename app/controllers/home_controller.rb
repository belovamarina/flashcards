class HomeController < ApplicationController
  include RandomCard
  before_action :set_random_card

  def index; end
end
