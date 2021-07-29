Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'application#welcome'

  resources :merchants, only: [:index] do
    resources :items, only: [:index, :show, :edit]
  end
end
