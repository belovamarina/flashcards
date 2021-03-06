require 'rails_helper'

RSpec.feature 'Card check', type: :feature do
  let!(:user) { login_user(create(:user_with_decks)) }

  scenario 'user see random card from current deck on home page' do
    visit root_path
    text = page.find(:xpath, "//h3[@class='panel-title']").text
    deck = user.decks.first
    user.update(current_deck_id: deck.id)
    expect(deck.cards.needed_to_review.pluck(:translated_text)).to include(text)
  end

  scenario 'user see random card (only noncurrent decks) on home page' do
    visit root_path
    text = page.find(:xpath, "//h3[@class='panel-title']").text
    user.update(current_deck_id: nil)
    expect(user.cards.needed_to_review.pluck(:translated_text)).to include(text)
  end

  scenario 'user fill in correct word', js: true do
    visit root_path
    text = page.find(:xpath, "//h3[@class='panel-title']").text

    within(:xpath, "//form[@class='simple_form card']") do
      fill_in 'card[original_text]', with: Card.find_by(translated_text: text).original_text
      click_button('Check it')
    end

    expect(page).to have_content 'Correct'
  end

  scenario 'user fill in correct word with mistape', js: true do
    visit root_path
    text = page.find(:xpath, "//h3[@class='panel-title']").text

    within(:xpath, "//form[@class='simple_form card']") do
      fill_in 'card[original_text]', with: Card.find_by(translated_text: text).original_text + 'a'
      click_button('Check it')
    end

    expect(page).to have_content 'Correct'
  end

  scenario 'user fill in wrong word', js: true do
    visit root_path

    within(:xpath, "//form[@class='simple_form card']") do
      fill_in 'card[original_text]', with: 'wrong word'
      click_button('Check it')
    end

    expect(page).to have_content 'Wrong'
  end
end
