require 'rails_helper'

RSpec.feature 'User create and edit deck', type: :feature do
  let!(:user) { login_user(create(:user)) }

  scenario 'user create new deck' do
    visit new_deck_path
    within(:xpath, "//form[@class='simple_form form-group']") do
      fill_in 'deck[name]', with: 'test'
      click_button('Save')
    end

    expect(page).to have_content 'test'

    visit edit_deck_path(user.decks.first.id)
    within(:xpath, "//form[@class='simple_form form-group']") do
      fill_in 'deck[name]', with: 'test1'
      check 'deck_user_attributes_current_deck_id'
      click_button('Edit')
    end

    expect(page).to have_content 'test1'
    expect(page).to have_xpath "//i[@class='fa fa-check-square-o fa-2x']"
  end
end
