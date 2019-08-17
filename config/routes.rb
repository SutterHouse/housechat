Rails.application.routes.draw do
  root 'frontend#index'

  resources :messages, only: [:index, :create]
  get "/messages/recent/:last_redis_id", to: "messages#recent"

  resources :users, only: [:create, :show]

  mount ActionCable.server => '/cable'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
