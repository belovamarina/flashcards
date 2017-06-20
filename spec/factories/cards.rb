FactoryGirl.define do
  factory :card do
    original_text 'factory'
    translated_text 'фабрика'
    success_reviews 0
    fail_reviews 0
    review_date { Date.today }
    deck
  end

  factory :bad_card, class: Card do
    original_text 'Factory '
    translated_text ' factory'
    review_date { 3.days.from_now }
    deck
  end
end
