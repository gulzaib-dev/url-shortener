# frozen_string_literal: true

# The `Url` model represents a shortened URL in the application. It provides methods for generating unique slugs,validating the original URL,
# and incrementing the number of clicks on a URL. It also includes scopes for finding the latest URLs created in the system.
#
# Attributes:
# - slug: a unique identifier for the shortened URL, consisting of five uppercase letters
# - original_url: the original URL that the shortened URL points to
# - clicked: the number of times the shortened URL has been clicked
#
# Validations:
# - `slug` must be present, unique, and consist of five uppercase letters
# - `original_url` must be present, a valid URL format, and between 6 and 255 characters long
#
# Callbacks:
# - `generate_slug`: automatically generates a unique slug before validation, if one is not already present
# - `remove_spaces`: removes any spaces from the original URL before saving
#
# Scopes:
# - `latest`: orders the URLs by creation date in descending order and returns the 10 most recent URLs
class Url < ApplicationRecord
  validates :slug, presence: true, uniqueness: true, length: { is: 5 }, format: { with: /[A-Z]{5}/ }

  validates :original_url, presence: true, length: { minimum: 6, maximum: 255 },
                           format: URI::DEFAULT_PARSER.make_regexp(%w[http https])

  before_validation :generate_slug
  before_save :remove_spaces

  scope :latest, -> { order(created_at: :desc).limit(10) }

  def increment_clicked_count
    increment!(:clicked)
  end

  private

  def generate_slug
    return if slug.present?

    loop do
      self.slug = SecureRandom.send(:choose, [* 'A'..'Z'], 5)
      break unless Url.exists?(slug: slug)
    end
  end

  def remove_spaces
    original_url.gsub!(/\s+/, '')
  end
end
