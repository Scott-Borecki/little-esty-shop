Rails.application.routes.draw do

  get '/', to: 'application#welcome'

  resources :merchants, only: [:index] do
    resources :items, exclude: [:destroy]
  end
  # FIX: (Scott B) Use exclude instead of only
  namespace :admin do
    resources :merchants, except: [:destroy]
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
  end

  # FIX: (Kim A) Nest within resources :merchants like on lines 5 & 6.  After updating, will need to confirm route URIs work
  namespace :merchants do
    get '/:merchant_id/invoices', to: 'invoices#index'
    get '/:merchant_id/invoices/:invoice_id', to: 'invoices#show'
  end
end
