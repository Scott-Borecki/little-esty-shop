Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  namespace :admin do
    resources :merchants, only: [:index]
  end
end
