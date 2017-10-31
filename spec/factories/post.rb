# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title 'A New Post'
    body Faker::Lorem.paragraph(2)
  end
end
