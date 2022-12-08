Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :payment_requests, only: :index do
    member do
      put :reject
      put :approve
    end
  end

  root "payment_requests#index"
end
