Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  namespace :admin do
    resources :merchants, only: [:create, :edit, :index, :new, :show, :update]
  end
end
