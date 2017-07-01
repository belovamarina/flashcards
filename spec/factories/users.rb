FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    email
    locale 'en'
    password 'secret'
    password_confirmation 'secret'
    salt { salt = 'asdasdastr4325234324sdfds' }
    crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt('secret', salt) }

    factory :user_ru do
      locale 'ru'
    end

    factory :user_with_decks do
      transient { decks_count 5 }

      after(:create) do |user, evaluator|
        create_list(:deck_with_cards, evaluator.decks_count, user: user)
      end
    end

    factory :user_with_noncurrent_decks do
      transient { decks_count 5 }

      after(:create) do |user, evaluator|
        create_list(:noncurrent_deck_with_cards, evaluator.decks_count, user: user)
      end
    end
  end

  factory :bad_user, class: User do
    email 'abcd'
    password '1234'
    locale 'en'
    password_confirmation ''
  end
end
