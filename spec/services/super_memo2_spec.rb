describe SuperMemo2 do
  context '.remember_card' do
    let(:card) { create(:card) }
    let(:supermemo) { SuperMemo2.new(card, 5) }

    it 'updates interval, e_factor, success_reviews' do
      attributes = supermemo.remember_card
      expect(attributes[:interval]).to eq(1)
      expect(attributes[:e_factor]).to eq(2.6)
      expect(attributes[:success_reviews]).to eq(1)
    end
  end

  context '.forgot_card' do
    let(:card) { create(:card) }
    let(:supermemo) { SuperMemo2.new(card) }

    it 'updates interval, review_date, success_reviews' do
      attributes = supermemo.forgot_card
      expect(attributes[:interval]).to eq(0)
      expect(attributes[:review_date]).to be { Date.today + 1 }
      expect(attributes[:success_reviews]).to eq(0)
    end
  end
end
