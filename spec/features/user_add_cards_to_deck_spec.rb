require 'rails_helper'

RSpec.feature 'User create cards in the deck', type: :feature do
  let!(:user) { login_user(create(:user_with_decks)) }

  scenario 'user add cards' do
    visit new_deck_card_path(user.decks.first)
    within(:xpath, "//form[@id='new_card']") do
      fill_in 'card[original_text]', with: 'test'
      fill_in 'card[translated_text]', with: ' Tест'
      attach_file 'card_image', "#{::Rails.root}/spec/support/30zvo.jpg"
      click_button('Save')
    end
    expect(page).to have_content 'test'
    expect(page).to have_content { 3.days.from_now }
    expect(page).to have_xpath "//div[@class='panel-body']/img[contains(@src, '30zvo.jpg')]"
  end
end
