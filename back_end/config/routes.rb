Rails.application.routes.draw do
  # routes used by react router
  get '/', to: 'web_application#index'
  get '/home', to: redirect('/')
  get '/game', to: redirect('/')
  get '/lobby', to: redirect('/')

end
