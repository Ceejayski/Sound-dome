Rails.application.routes.draw do
  resources :categories, only: [:show] do
  end
  resources :articles do
    resources :votes
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'
end
