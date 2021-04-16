Rails.application.routes.draw do
  devise_for :admins
  get 'test_articles/index'
  get 'comments/index'
  root 'articles#index'

  resources :test_articles, only: :index

  namespace :articles do
    post 'csv_upload'
  end

  resources :categories

  resources :articles do
    resources :comments
  end
end
