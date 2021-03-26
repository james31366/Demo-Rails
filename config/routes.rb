Rails.application.routes.draw do
  devise_for :admins
  get 'test_articles/index'
  get 'comments/index'
  root 'articles#index'
  #
  # get '/welcomes', to: 'welcomes#index'
  # get '/articles', to: 'articles#index'

  resources :test_articles, only: :index
  resources :articles do
    resources :comments
  end
end
