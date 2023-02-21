Rails.application.routes.draw do
  unless Rails.env.development?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == Rails.application.credentials(:sidekiq, :username) && password == Rails.application.credentials(:sidekiq, :password)
    end
  end

  mount Sidekiq::Web => '/sidekiq'

  namespace :admin do
    resources :users
    resources :transactions
    resources :double_entry_lines
  end
end
