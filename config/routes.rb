Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  resources :users, only: [:index, :create]
  resources :candidates, only: [:index, :create, :update]
  resources :candidate_matches, path: 'matches', only: [:index]
  resources :photos, only: [:create]
end
