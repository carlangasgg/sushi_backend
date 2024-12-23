require 'sidekiq/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == 'admin' && password == 'password'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :admin do
    get 'check_device_status', to: 'admin#check_device_status'
    patch 'update_device_status', to: 'admin#update_device_status'
  end

  namespace :device do
    get 'show_pos', to: 'device#show_pos'
    get 'show_printers', to: 'device#show_printers'
    get 'show_red_systems', to: 'device#show_red_systems'
    get 'show_locales', to: 'device#show_locales'

    get 'show_pos_job', to: 'device#show_pos_job'
    get 'show_printers_job', to: 'device#show_printers_job'
    get 'show_red_systems_job', to: 'device#show_red_systems_job'
  end
end
