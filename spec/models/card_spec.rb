require 'rails_helper'

RSpec.describe Card, type: :model do
  describe '#text_uniqueness' do
    context 'when create valid card' do
      subject(:card) { build(:card) }
      it { is_expected.to be_valid }
    end

    context 'when create non-valid card' do
      subject(:bad_card) { build(:bad_card) }
      it { is_expected.not_to be_valid }
      it 'show errors' do
        bad_card.valid?
        expect(bad_card.errors[:original_text]).to include('Текст должен быть разным')
      end
    end
  end

  describe '#compare' do
    let(:card) { create(:card) }

    context 'when checking correct word' do
      subject { card.compare(' Factory') }
      it { is_expected.to be(0) }
    end

    context 'when checking correct word with mistape' do
      subject { card.compare(' Fcatory') }
      it { is_expected.to be < 3 }
    end

    context 'when checking wrong word' do
      subject { card.compare('cat') }
      it { is_expected.to be > 2 }
    end
  end
end
