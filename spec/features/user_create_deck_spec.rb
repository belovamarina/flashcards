require 'rails_helper'

RSpec.feature 'User create deck', type: :feature do
  let!(:user) { login_user(create(:user)) }

  scenario 'user create new deck' do
    visit new_deck_path
    within(:xpath, "//form[@id='new_deck']") do
      fill_in 'Имя колоды', with: 'test'
      check 'status_current'
      click_button('Создать')
    end

    expect(page).to have_content 'test'
    expect(page).to have_xpath "//span[@class='glyphicon glyphicon-ok']"
  end
end
