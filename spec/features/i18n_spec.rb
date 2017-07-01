require 'rails_helper'

RSpec.feature 'i18n (ru and en langs)', type: :feature do
  scenario 'EN locale sets from user s browser' do
    page.driver.header('Accept-Language', 'en-US;q=0.8,en;q=0.4')
    visit root_path
    expect(page).to have_content "The world's first"
  end

  scenario 'RU locale sets from user s browser' do
    page.driver.header('Accept-Language', 'ru;q=0.8,en;q=0.4')
    visit root_path
    expect(page).to have_content 'Флэшкарточкер'
  end

  scenario 'priority of user locale is higher then browser locale' do
    page.driver.header('Accept-Language', 'en-US;q=0.8,en;q=0.4')
    login_user(create(:user_ru))
    visit root_path
    expect(page).to have_content 'Флэшкарточкер'
  end

  scenario 'user can change locale' do
    login_user(create(:user_ru))
    visit root_path
    click_link('EN')
    expect(page).to have_content "The world's first"
  end

  scenario 'anonim can change locale' do
    page.driver.header('Accept-Language', 'en-US;q=0.8,en;q=0.4')
    visit root_path
    click_link('RU')
    expect(page).to have_content 'Флэшкарточкер'
  end
end
