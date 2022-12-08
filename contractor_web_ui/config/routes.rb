Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :payment_requests, only: [:index, :create, :new]

  root "payment_requests#index"
end
