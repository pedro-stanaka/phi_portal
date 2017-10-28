FactoryBot.define do
  factory :post do
    title Faker::HitchhikersGuideToTheGalaxy.quote
    body Faker::Lorem.paragraph(2)
  end
end