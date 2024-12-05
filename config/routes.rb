Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :admin do
    get 'something', to: 'admin#something'
    get 'check_device_status', to: 'admin#check_device_status'
    patch 'update_device_status', to: 'admin#update_device_status'
  end

  namespace :device do
    get 'show_pos', to: 'device#show_pos'
    get 'show_printers', to: 'device#show_printers'
    get 'show_red_systems', to: 'device#show_red_systems'
    get 'show_locales', to: 'device#show_locales'
  end
end
