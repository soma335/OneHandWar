Rails.application.routes.draw do
  namespace :api do
    resources :combats, only: [:index, :create, :update]
  end

  devise_for :users
  resources :users, only: [:show]

  resources :home, only: [:index, :show]
  root to: 'home#index'
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
