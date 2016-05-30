Rails.application.routes.draw do

  root 'home#index'
  namespace :manage, as: nil do
    devise_for :users,
               controllers: {
                   sessions: 'custom_devise/sessions',
                   registrations: 'custom_devise/registrations',
                   passwords: 'custom_devise/passwords'
               }

    resources :users
    resources :customers, only: [:index, :show]
    resources :services
    resources :orders, only: [:index, :show], shallow: true
  end
  namespace :clients, as: nil do
    devise_for :customers,
               controllers: {
                   sessions: 'custom_devise/sessions',
                   registrations: 'custom_devise/registrations',
                   passwords: 'custom_devise/passwords'
               }
    resources :customers, as: :clients, only: [:show, :edit, :update]
    resources :services, as: :available_services, only: [:index]
    resources :orders, as: :bookings, only: [:index, :show, :new, :create], shallow: true
  end
  resources :home, only: [:index]

  post '/get_model', to: 'make_model#index'
  post '/calculate_price', to: 'price#index'
end
