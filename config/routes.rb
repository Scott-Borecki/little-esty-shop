Rails.application.routes.draw do
  get '/', to: 'application#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :merchants do
    get '/:merchant_id/invoices', to: 'invoices#index'
    get '/:merchant_id/invoices/:invoice_id', to: 'invoices#show'
  end
end
