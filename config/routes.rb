Rails.application.routes.draw do
  devise_for :admins
  get 'comments/index'
  root 'articles#index'
  #
  # get '/welcomes', to: 'welcomes#index'
  # get '/articles', to: 'articles#index'
  resources :articles do
    resources :comments
  end
end
