# frozen_string_literal: true

# This file contains code to seed the database with fake data for testing purposes using the Faker gem.
# The code generates 30 URLs with random original URLs, slugs, and click counts using the `Url.create` method.
# Each URL is created with the following attributes:
# - original_url: a random URL generated using the `Faker::Internet.url` method.
# - slug: a random letter only string with at least 5 characters (5 letters and 0 or more numbers) generated using the `Faker::Alphanumeric.alphanumeric` method and converted to uppercase.
# - clicked: a random number between 1 and 300 generated using the `rand` method.
#
# This file is intended to be run using the `rails db:seed` command, which will execute the code in this file to populate the database with fake data.
# Note that the `Url` model must be defined in your application for this script to work.
# This file assumes that the `Faker` gem is already installed in your application.
# It is recommended to run this file in a development or test environment to avoid seeding production data.

30.times do
  Url.create(
    original_url: Faker::Internet.url,
    slug: Faker::Alphanumeric.alphanumeric(number: 5, min_alpha: 5, min_numeric: 0).upcase,
    clicked: rand(1...300)
  )
end
