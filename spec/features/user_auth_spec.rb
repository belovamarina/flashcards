require 'rails_helper'

RSpec.feature 'User Authentication', type: :feature do
  scenario 'anonym dont see card test' do
    visit root_path
    text = page.all(:xpath, "//h3[@class='panel-title']").map(&:text)
    expect(text).to be_empty
  end

  scenario 'anonym cant create or see cards' do
    [cards_path, new_card_path].each do |path|
      visit path
      expect(page.current_path).to eq login_path
    end
  end

  scenario 'user cant edit another user cards' do
    user = create(:user_with_cards)
    login_user(create(:user_with_cards))
    [edit_card_path(user.cards.first), card_path(user.cards.last)].each do |path|
      visit path
      expect(page).to have_content 'Вам сюда нельзя'
    end
  end
end
