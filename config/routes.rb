Rails.application.routes.draw do
  get '/', to: 'application#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants do
    resources :invoices, only: [:index, :show, :update], controller: 'merchants/invoices'
  end
end
