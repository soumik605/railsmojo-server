Rails.application.routes.draw do

  namespace :admin do
    resources :articles
    resources :categories
    resources :rails_versions
  end

  resources :articles, only: [:index, :show]
  get 'admin' => 'admin/articles#index'
  
  devise_for :users
  get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end
