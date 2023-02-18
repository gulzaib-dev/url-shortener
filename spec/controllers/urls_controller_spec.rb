# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  describe 'index' do
    let(:url1) { create(:url, :spaces) }
    let(:url2) { create(:url, :spaces) }

    context 'checks if it routes to the index' do
      it { expect(get: '/urls').to route_to(controller: 'urls', action: 'index') }
    end

    context 'checks if it returns all URLS' do
      before do
        get :index
      end
      it { expect(assigns(:urls)).to match_array([url1, url2]) }
    end
  end

  describe 'new' do
    context 'checks if it routes to the new' do
      it { expect(get: '/urls/new').to route_to(controller: 'urls', action: 'new') }
    end

    context 'checks if it initialize url' do
      before do
        get :new
      end
      it { expect(assigns(:url)).to be_a_new(Url) }
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { { url: { original_url: 'http://www.example.com' } } }
      before do
        post :create, params: valid_params
      end

      it 'creates a new url' do
        expect(Url.count).to eq(1)
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash notice' do
        expect(flash[:notice]).to eq('Url created')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { url: { original_url: '' } } }
      before do
        post :create, params: invalid_params
      end

      it 'does not create a new url' do
        expect(Url.count).to eq(0)
      end

      it 'redirects to the new url path' do
        expect(response).to redirect_to(new_url_path)
      end

      it 'sets a flash notice with errors' do
        expect(flash[:alert]).to include("Original url can't be blank",
                                         'Original url is too short (minimum is 6 characters)',
                                         'Original url is invalid')
      end
    end
  end

  describe '#redirect' do
    context 'when the URL exists' do
      let(:url) { create(:url, :spaces) }
      before { get :redirect, params: { slug: url.slug } }

      it 'finds the URL with the given slug' do
        expect(assigns(:url)).to eq(url)
      end

      it 'increments the clicked count for the UR' do
        expect(url.reload.clicked).to eq(1)
      end

      it 'redirects to the original URL' do
        expect(response).to redirect_to(url.original_url)
      end
    end

    context "when the URL doesn't exist" do
      before do
        get :redirect, params: { slug: 'non-existing-slug' }
      end

      it 'renders a 404 error page' do
        expect(response).to have_http_status(404)
        # expect(response.body).to include("The page you were looking for doesn't exist.")
      end
    end
  end
end
