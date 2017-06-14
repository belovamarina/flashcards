require 'rails_helper'

RSpec.describe Deck, type: :model do
  describe '#current?' do
    context 'should be only one current deck' do
      subject(:user) { create(:user_with_decks) }
      it 'set current deck' do
        user.update(current_deck_id: user.decks.first.id)
        user.update(current_deck_id: user.decks.last.id)
        expect(user.decks.last.current?).to be_truthy
      end
    end
  end

  describe '#cards' do
    context 'has many decks with cards' do
      subject(:deck) { create(:deck_with_cards) }
      it { expect(deck.cards).not_to be_empty }
    end
  end
end
