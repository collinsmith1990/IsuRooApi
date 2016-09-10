Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  resources :users, only: [:index, :create]
  resources :candidates, path: 'matches', only: [:index, :create, :update]
  resources :photos, only: [:create]
end
