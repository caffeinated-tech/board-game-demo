Rails.application.routes.draw do
  # routes used by react router
  get '/', to: 'web_application#index'
  get '/home', to: redirect('/')
  get '/game', to: redirect('/')
  get '/lobby', to: redirect('/')

  get '/logout', to: 'web_application#logout'


  namespace :api do
    post 'users/login', to: 'users#login'
    resources :users, only: [:create] do
    end
  end
end
