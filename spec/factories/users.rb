FactoryGirl.define do
  factory :user do
    email 'user1@example.com'
    password 'testpassword'

    factory :user_with_cards do
      transient { cards_count 5 }

      after(:create) do |user, evaluator|
        create_list(:card, evaluator.cards_count, user: user)
      end
    end
  end

  factory :bad_user, class: User do
    email 'abcd'
    password ''
  end
end
