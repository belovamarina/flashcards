require 'rails_helper'

RSpec.feature 'User Authentication', type: :feature do
  scenario 'anonym dont see card test' do
    visit root_path
    text = page.all(:xpath, "//h3[@class='panel-title']").map(&:text)
    expect(text).to be_empty
  end

  scenario 'anonym cant create or see cards' do
    [decks_path, new_deck_path].each do |path|
      visit path
      expect(page.current_path).to eq login_path
    end
  end

  scenario 'user cant edit another user cards' do
    user = create(:user_with_decks)
    login_user(create(:user_with_decks))
    [edit_deck_path(user.decks.first), deck_path(user.decks.last)].each do |path|
      visit path
      expect(page).to have_content 'Вам сюда нельзя'
    end
  end
end
