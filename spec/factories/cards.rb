FactoryGirl.define do
  factory :card do
    original_text 'factory'
    translated_text 'фабрика'
    review_date { Date.today }
  end

  factory :bad_card, class: Card do
    original_text 'Factory '
    translated_text ' factory'
    review_date { 3.days.from_now }
  end
end
