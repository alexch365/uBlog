FactoryBot.define do
  factory :rating do
    value { [1..5].sample }

    association :post
  end
end
