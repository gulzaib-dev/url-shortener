# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'urls#index'

  namespace :api do
    resources :urls, only: [:index]
  end

  resources :urls, only: %i[index new create]
  get '/:slug', to: 'urls#redirect'
end
