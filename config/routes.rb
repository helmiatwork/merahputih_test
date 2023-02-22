Rails.application.routes.draw do
  devise_for :administrators
  
  unless Rails.env.development?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == Rails.application.credentials(:sidekiq, :username) && password == Rails.application.credentials(:sidekiq, :password)
    end
  end

  mount Sidekiq::Web => '/sidekiq'

  root to: "admin/transactions#index"
  namespace :admin do
    root to: redirect("transactions/index")
    resources :users
    resources :transactions
  end
end
