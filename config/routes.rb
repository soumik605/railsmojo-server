Rails.application.routes.draw do
  namespace :admin do
    resources :articles, only: [:index, :show, :create, :update, :destroy]
    resources :categories, only: [:index, :show, :create, :update, :destroy]
    resources :rails_versions, only: [:index, :show, :create, :update, :destroy]
  end

  get 'admin' => 'admin/articles#index'

  resources :articles, only: [:index, :show]
 
  
  devise_for :users
  get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end
