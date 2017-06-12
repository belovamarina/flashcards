require 'rails_helper'

RSpec.describe Deck, type: :model do
  describe 'current and noncurrent status' do
    context 'when create 5 decks with current status' do
      subject(:user) { create(:user_with_decks) }
      it { expect(user.decks.current.count).to eq(1) }
    end

    context 'when create 5 decks with noncurrent status' do
      subject(:user) { create(:user_with_noncurrent_decks) }
      it { expect(user.decks.noncurrent.count).to eq(5) }
    end
  end
end
