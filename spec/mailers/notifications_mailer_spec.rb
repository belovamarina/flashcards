require 'rails_helper'

RSpec.describe NotificationsMailer, type: :mailer do
  describe 'notify' do
    let(:user) { create(:user_with_decks) }
    let(:mail) { NotificationsMailer.pending_cards(user) }

    it 'renders the headers' do
      expect(mail.subject).to match(user.email)
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      card = user.cards.where('review_date <= ?', Time.now).first
      expect(mail.body.encoded).to match(card.translated_text)
    end
  end
end
