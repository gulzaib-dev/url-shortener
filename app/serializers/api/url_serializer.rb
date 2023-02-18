# frozen_string_literal: true

# The `Api::UrlSerializer` class is responsible for serializing the `Url` model into JSON for use in the API.
# This serializer only includes the `original_url`, `slug`, and `clicked` attributes of the `Url` model.
# This class inherits from the `ActiveModel::Serializer` class, which provides a flexible way to define
# and customize the serialization of models in Rails.
#
# Attributes:
# - `original_url`: the original URL that the shortened URL points to
# - `slug`: a unique identifier for the shortened URL, consisting of five uppercase letters
# - `clicked`: the number of times the shortened URL has been clicked
module Api
  class UrlSerializer < ActiveModel::Serializer
    attributes :original_url, :slug, :clicked
  end
end
