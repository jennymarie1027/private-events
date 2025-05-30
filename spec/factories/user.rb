FactoryBot.define do
    factory :user do
        email { Faker::Internet.unique.email }
        password { "password" }
    end

    factory :invalid_user, class: 'User' do
        email { nil }
        password { nil }
    end
end