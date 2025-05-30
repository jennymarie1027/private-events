FactoryBot.define do
    factory :event do
        association :creator, factory: :user
        title { "Sample Event" }
        description { "This is a sample event description." }
        location { "Sample Location" }
        time { Time.current + 1.day }
    end
end