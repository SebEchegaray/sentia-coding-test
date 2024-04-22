Rails.application.routes.draw do
  resources :people, only: [:index]
  resources :importers, only: [:index] do
    collection { post :import }
  end

  root 'importers#index'
end
