Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'articles/index'
    end
  end
  devise_for :admins
  root 'homes#index'

  resources :homes

  resources :categories

  namespace :admins do
    namespace :articles do
      post 'csv_upload'
    end

    resources :test_articles, only: :index

    resources :articles do
      resources :comments
    end
  end

  namespace :api do
    namespace :v1 do
      resources :articles, only: [] do
        resources :comments, only: :index
      end
    end
  end
end
