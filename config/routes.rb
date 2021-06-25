# frozen_string_literal: true

Rails.application.routes.draw do
  resources :companies, only: [:show, :index] do
    resources :prices, only: [:show, :index]
  end
  resources :searches, only: [:create, :show, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
