# frozen_string_literal: true

# The `UrlsController` class is responsible for handling HTTP requests related to URLs in the application.
# It provides methods for creating and retrieving URL resources,
# As well as additional actions for handling related functionality such as short URL redirects and analytics.
#
# Actions:
# - index: GET /urls - returns a list of all URLs in the system, sorted by creation date.
# - new: GET /urls/new - displays a form for creating a new URL.
# - create: POST /urls - creates a new URL resource based on the parameters submitted in the request.
# - redirect: GET /:slug - redirects to the original URL associated with the specified slug,
#   And increments the clicked count for the associated URL resource.
#
# Private Methods:
# - url_create_params: returns a hash of parameters submitted for URL creation.
# - set_url: finds the URL resource based on the specified slug,
#   And increments the clicked count for the associated URL resource.
# - url_slug: returns the specified slug parameter from the request.
# - not_found: renders a custom 404 error page if the URL resource cannot be found for the specified slug.
class UrlsController < ApplicationController
  before_action :set_url, only: :redirect
  before_action :not_found, only: :redirect, unless: -> { @url }

  def index
    @urls = Url.order(created_at: :desc)
  end

  def new
    @url = Url.new
  end

  def create
    url = Url.new(url_create_params)
    if url.save
      redirect_to root_path, notice: 'Url created'
    else
      redirect_to new_url_path, alert: url.errors.full_messages
    end
  end

  def redirect
    redirect_to @url.original_url
  end

  private

  def url_create_params
    params.require(:url).permit(:original_url)
  end

  def set_url
    @url = Url.find_by(slug: url_slug)
    @url&.increment_clicked_count
  end

  def url_slug
    params.require(:slug)
  end

  def not_found
    render file: "#{Rails.root}/public/404.html", status: 404
  end
end
