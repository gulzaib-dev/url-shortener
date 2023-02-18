# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    slug {}
    clicked { 0 }
  end

  trait :spaces do
    original_url { 'https: // test. com' }
  end

  trait :no_spaces do
    original_url { Faker::Internet.url }
  end

  trait :https do
    original_url { 'https://example.com' }
  end

  trait :http do
    original_url { 'http://example.org' }
  end

  trait :random do
    original_url { "http://example.org/#{rand(1...1000)}" }
  end
end
