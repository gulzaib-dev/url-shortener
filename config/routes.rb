# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'urls#index'

  resources :urls, only: %i[index new create]
  get '/:slug', to: 'urls#redirect'
end
