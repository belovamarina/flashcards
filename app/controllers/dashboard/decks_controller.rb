module Dashboard
  class DecksController < ApplicationController
    before_action :require_login
    before_action :set_deck, :check_user, only: %i[show edit update destroy]

    def index
      @decks = current_user.decks
      @count = @decks.count
    end

    def show; end

    def new
      @deck = Deck.new
    end

    def create
      @deck = current_user.decks.build(deck_params)
      if @deck.save
        redirect_to @deck
      else
        render :new
      end
    end

    def edit; end

    def update
      if @deck.update(deck_params)
        redirect_to @deck
      else
        render :edit
      end
    end

    def destroy
      @deck.destroy
      redirect_to decks_path
    end

    private

    def set_deck
      @deck = Deck.find(params[:id])
    end

    def deck_params
      params.require(:deck).permit(:name, user_attributes: %i[current_deck_id id])
    end

    def check_user
      return if current_user.decks.exists?(@deck.id)
      render status: :forbidden, plain: 'Вам сюда нельзя'
    end
  end
end
