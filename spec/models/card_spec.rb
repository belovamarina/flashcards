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

  describe '#success_review' do
    let(:card) { create(:card) }

    context 'when success reviews' do
      subject { card.success_review }

      it 'increase success reviews' do
        subject
        expect(card.success_reviews).to eq(1)
      end

      it 'increase review date via INTERVALS' do
        expect(card.review_date).to be { 12.hours.from_now }
      end
    end

    context 'when fail first time' do
      before do
        card.fail_review
      end

      it 'not decrease success reviews if it == 0' do
        expect(card.success_reviews).to eq(0)
      end

      it 'increase fail reviews' do
        expect(card.fail_reviews).to eq(1)
      end

      it 'data review not changes' do
        expect { card.fail_review }.to_not change { card.review_date }
      end
    end

    context 'when fail 3 times after success' do
      before do
        3.times { card.success_review }
        3.times { card.fail_review }
      end

      it 'decrease success from 3 to 2' do
        expect(card.success_reviews).to eq(2)
      end

      it 'increase fail reviews' do
        expect(card.fail_reviews).to eq(3)
      end

      it 'data review is changes' do
        expect(card.review_date).to be { 3.days.from_now }
      end
    end
  end
end
