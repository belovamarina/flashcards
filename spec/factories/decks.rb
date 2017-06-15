FactoryGirl.define do
  factory :deck do
    user
    name 'test_deck'
    factory :deck_with_cards do
      transient { cards_count 5 }

      after(:create) do |deck, evaluator|
        create_list(:card, evaluator.cards_count, deck: deck)
      end
    end
  end
end
