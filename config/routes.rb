Rails.application.routes.draw do
  get 'signup', to: 'members#new',      as: 'signup'
  get 'login',  to: 'sessions#new',     as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :gamblings, only: [:create, :show, :destroy] do
    resources :rolls, only: [:edit, :new, :update]
    member do
      get 'delete'
    end
  end
  resources :guests, only: [:create]
  resources :members, only: [:create]
  resources :sessions, only: [:create]
  resources :users, only: [:show]

  root :to => 'gamblings#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
