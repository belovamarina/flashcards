require 'rails_helper'

RSpec.feature 'Card check', type: :feature do
  let!(:user) { login_user(create(:user_with_decks)) }

  scenario 'user see random card from current deck on home page' do
    visit root_path
    text = page.find(:xpath, "//h3[@class='panel-title']").text
    deck = user.decks.current.first
    expect(deck.cards.needed_to_review.pluck(:translated_text)).to include(text)
  end

  scenario 'user see random card (only noncurrent decks) on home page' do
    visit root_path
    text = page.find(:xpath, "//h3[@class='panel-title']").text
    user.decks.update_all(status: 'noncurrent')
    expect(user.cards.needed_to_review.pluck(:translated_text)).to include(text)
  end

  scenario 'user fill in correct word' do
    visit root_path
    text = page.find(:xpath, "//h3[@class='panel-title']").text

    within(:xpath, "//form[@class='simple_form card']") do
      fill_in ' Помните перевод?', with: Card.find_by(translated_text: text).original_text
      click_button('Проверить')
    end

    expect(page).to have_content 'Правильно'
  end

  scenario 'user fill in wrong word' do
    visit root_path

    within(:xpath, "//form[@class='simple_form card']") do
      fill_in ' Помните перевод?', with: 'wrong word'
      click_button('Проверить')
    end

    expect(page).to have_content 'Неправильно'
  end
end
