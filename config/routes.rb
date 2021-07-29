Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  namespace :admin do
    resources :merchants, only: [:edit, :index, :show, :update]
  end
end
