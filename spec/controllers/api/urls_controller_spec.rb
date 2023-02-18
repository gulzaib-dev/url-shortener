# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::UrlsController, type: :controller do
  describe 'GET #index' do
    before do
      # create some test data
      Url.create(original_url: 'https://example.com')
      Url.create(original_url: 'https://example.org')
    end

    it 'returns a list of the latest URLs' do
      get :index

      # check the response status code
      expect(response.status).to eq(200)

      # check the response body
      response_data = JSON.parse(response.body)
      expect(response_data.length).to eq(2)

      # check the contents of the response can add full content check
      expect(response_data[0]['original_url']).to eq('https://example.com')
      expect(response_data[1]['original_url']).to eq('https://example.org')
    end
  end
end
