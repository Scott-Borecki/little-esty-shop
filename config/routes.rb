Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  resources :merchants do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
    resources :items, exclude: [:destroy]
  end

  # FIX: (Scott B) Use exclude instead of only
  namespace :admin do
    resources :merchants, only: [:create, :edit, :index, :new, :show, :update]
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
  end
end
