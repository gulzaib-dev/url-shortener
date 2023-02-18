# frozen_string_literal: true

# The `UrlsHelper` module provides a helper method for constructing a URL that includes a short slug based on the specified `slug` parameter.
# This method can  be used to generate URLs for sharing and redirecting to shortened URLs within the application.
module UrlsHelper
  # Generates a URL for the specified slug, using the `HOST_NAME` environment variable if it is present, or falling back to the current request's
  # `host_with_port` value if not.
  # Parameters:
  # - slug: the short slug for which to generate a URL
  #
  # Returns:
  # A string containing a URL that includes the specified `slug`.
  def get_slug_url(slug)
    return "#{ENV['HOST_NAME']}/#{slug}" if ENV['HOST_NAME'].present?

    "http://#{request.host_with_port}/#{slug}"
  end
end
