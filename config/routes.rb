Rails.application.routes.draw do
  devise_for :users
  root "events#index"

  resources :events do
    member do
      post 'invite', to: 'events#invite', as: :invite
    end
  end

  resources :rsvps, only: [:create, :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
