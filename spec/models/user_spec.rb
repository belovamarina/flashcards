require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#email' do
    context 'when create valid user' do
      subject(:user) { build(:user) }
      it { is_expected.to be_valid }
    end

    context 'when create non-valid user' do
      subject(:bad_user) { build(:bad_user) }
      it { is_expected.not_to be_valid }
      it 'show errors' do
        bad_user.valid?
        expect(bad_user.errors[:email]).to include('abcd -- неправильный формат email')
      end
    end
  end

  describe '#cards' do
    context 'user has many cards' do
      subject(:user) { create(:user_with_cards) }
      it { expect(user.cards).not_to be_empty }
    end
  end
end
