Rails.application.routes.draw do
  get '/', to: 'application#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #merchant invoices ---------------------------------
  resources :merchants do
    resources :invoices
  end
end
