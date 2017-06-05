FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    email
    password 'secret'
    password_confirmation 'secret'
    salt { salt = 'asdasdastr4325234324sdfds' }
    crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt('secret', salt) }

    factory :user_with_cards do
      transient { cards_count 5 }

      after(:create) do |user, evaluator|
        create_list(:card, evaluator.cards_count, user: user)
      end
    end
  end

  factory :bad_user, class: User do
    email 'abcd'
    password '1234'
    password_confirmation ''
  end
end
