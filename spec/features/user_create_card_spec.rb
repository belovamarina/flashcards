require 'rails_helper'

RSpec.feature 'User create card', type: :feature do
  let!(:user) { login_user(create(:user)) }

  scenario 'user create new card' do
    visit new_card_path
    within(:xpath, "//form[@id='new_card']") do
      fill_in ' Оригинальный текст', with: 'test'
      fill_in ' Перевод', with: ' Tест'
      attach_file 'card_image', "#{::Rails.root}/spec/support/30zvo.jpg"
      click_button('Создать')
    end
    expect(page).to have_content 'test'
    expect(page).to have_content { 3.days.from_now }
    expect(page).to have_xpath "//div[@class='panel-body']/img[contains(@src, '30zvo.jpg')]"
  end
end
