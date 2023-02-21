Rails.application.routes.draw do
  unless Rails.env.development?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == Rails.application.credentials(:sidekiq, :username) && password == Rails.application.credentials(:sidekiq, :password)
    end
  end

  mount Sidekiq::Web => '/sidekiq'

  root to: "admin/users#index"
  namespace :admin do
    root to: redirect("admin/users")
    resources :users
    resources :transactions
  end
end
