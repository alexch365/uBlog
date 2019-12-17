FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph(sentence_count: 20) }
    author_ip { Faker::Internet.ip_v4_address }

    association :user
  end
end
