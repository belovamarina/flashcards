class CardsController < ApplicationController
  include RandomCard
  before_action :require_login
  before_action :set_card, :check_user, only: %i[show edit update destroy]
  before_action :set_deck, only: %i[new create edit update destroy]
  before_action :set_random_card, :set_card_for_check, only: :check_card

  def index
    @cards = current_user.cards
    @count = @cards.count
  end

  def show; end

  def new
    @card = @deck.cards.build
  end

  def create
    @card = @deck.cards.build(card_params)
    if @card.save
      redirect_to deck_card_path(@card.deck, @card)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @card.update(card_params)
      redirect_to deck_card_path(@card.deck, @card)
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to @deck
  end

  def check_card
    supermemo = SuperMemo2.new(@card, card_params[:quality])

    respond_to do |format|
      if @card.compare(card_params[:original_text]) < 3
        @card.update(supermemo.remember_card)
        format.js { flash.now[:notice] = t('.success', user_answer: card_params[:original_text], original: @card.original_text) }
      else
        @card.update(supermemo.forgot_card)
        format.js { flash.now[:alert] = t('.alert') }
      end
    end
  end

  private

  def set_card_for_check
    @card = current_user.cards.find(card_params[:card_id])
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def set_deck
    @deck = current_user.decks.find(params[:deck_id])
  end

  def card_params
    params.require(:card).permit(
      :original_text,
      :translated_text,
      :review_date,
      :card_id,
      :image,
      :remote_image_url,
      :deck_id,
      :quality
    )
  end

  def check_user
    return if current_user.cards.exists?(@card.id)
    render status: :forbidden, plain: 'Вам сюда нельзя'
  end
end
