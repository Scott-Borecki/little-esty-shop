Rails.application.routes.draw do
  get '/', to: 'application#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
  end 
end
