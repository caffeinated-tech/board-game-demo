Rails.application.routes.draw do
  # routes used by react router
  get '/', to: 'web_application#index'
  get '/home', to: 'web_application#index'
  get '/game', to: 'web_application#index'
  get '/lobby/', to: 'web_application#index'
  get '/lobby/create', to: 'web_application#index'

  get '/logout', to: 'web_application#logout'


  namespace :api do
    post 'users/login', to: 'users#login'
    resources :users, only: [:create] do
    end
  end
end
