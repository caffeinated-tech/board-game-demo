Rails.application.routes.draw do
  # routes used by react router
  get '/', to: 'web_application#index'
  get '/home', to: 'web_application#index'
  get '/game', to: 'web_application#index'
  get '/lobby/', to: 'web_application#index'
  get '/lobby/create', to: 'web_application#index'
  get '/lobby/games/open', to: 'web_application#index'
  get '/lobby/games/playing', to: 'web_application#index'
  get '/lobby/players', to: 'web_application#index'

  get '/logout', to: 'web_application#logout'

  namespace :api do
    # login and signup
    post 'users/login', to: 'users#login'
    resources :users, only: [:create] do
    end

    # creating and joining games
    resources :games, only: [:index, :create, :delete] do
      post 'join', to: 'games#join'
      post 'move', to: 'games#move'
    end
  end
end
