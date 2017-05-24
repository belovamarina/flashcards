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

  describe '#correct_translate?' do
    let(:card) { create(:card) }

    context 'when checking correct word' do
      subject { card.correct_translate?(' Factory') }
      it { is_expected.to be_truthy }
      it { expect(card.review_date).to be { 3.days.from_now } }
    end

    context 'when checking wrong word' do
      subject { card.correct_translate?('cat') }
      it { is_expected.to be_falsey }
    end
  end
end
