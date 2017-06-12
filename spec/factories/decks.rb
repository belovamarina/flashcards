FactoryGirl.define do
  factory :deck do
    user
    name 'test_deck'
    status 'current'
    factory :deck_with_cards do
      transient { cards_count 5 }

      after(:create) do |deck, evaluator|
        create_list(:card, evaluator.cards_count, deck: deck)
      end
    end
  end

  factory :noncurrent_deck, class: Deck do
    name 'test_deck'
    status 'noncurrent'
    user
    factory :noncurrent_deck_with_cards do
      transient { cards_count 5 }

      after(:create) do |noncurrent_deck, evaluator|
        create_list(:card, evaluator.cards_count, deck: noncurrent_deck)
      end
    end
  end
end
