# frozen_string_literal: true

# The `Api::UrlsController` class is responsible for handling HTTP requests related to URLs in the API of the application.
# It provides an `index` action that  returns a JSON response containing a list of the latest URLs in the system,
# based on the `latest` scope provided by the `Url` model.
#
# This controller is part of the `Api` module, which groups together controllers and
# other components related to the application's API functionality.
#
# Actions:
# - index: GET /api/urls - returns a JSON response containing a list of the latest URLs in the system,
#  based on the `latest` scope provided by the `Url`
module Api
  class UrlsController < ApplicationController
    # Returns a JSON response containing a list of the latest URLs in the system.
    def index
      latest_urls = Url.latest
      render json: latest_urls
    end
  end
end
