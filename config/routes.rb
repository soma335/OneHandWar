Rails.application.routes.draw do
  namespace :api do
    get 'combat/index'
    get 'combat/create'
  end
  devise_for :users

  resources :home
  root to: 'home#index'
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
