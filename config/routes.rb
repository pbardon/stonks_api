Rails.application.routes.draw do
  resources :companies, param: :ticker do
    resources :prices
  end
  resources :searches
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
