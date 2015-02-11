Rails.application.routes.draw do

  get "/browse" => "asciicasts#index", as: :browse
  get "/browse/:category" => "asciicasts#index", as: :category

  get '/a/:id.js', to: redirect(ActionController::Base.helpers.asset_path('widget.js'), status: 301)

  resources :asciicasts, path: 'a' do
    member do
      get '/raw', to: 'api/asciicasts#show'
      get :example
    end
  end

  get "/u/:id" => "users#show", as: :unnamed_user
  get "/~:username" => "users#show", as: :public_profile

  namespace :api do
    resources :asciicasts
  end

  get "/docs" => "docs#show", :page => 'getting-started', as: :docs_index
  get "/docs/:page" => "docs#show", as: :docs

  resource :login do
    get :sent
  end

  get "/login" => redirect("/login/new")

  get "/login/:token", to: "sessions#create", as: :login_token
  get "/logout", to: "sessions#destroy"

  resource :user
  resource :username do
    get :skip
  end

  get '/connect/:udid', to: 'devices#create'

  root 'home#show'

  get '/about', to: 'pages#show', page: :about, as: :about
  get '/privacy', to: 'pages#show', page: :privacy, as: :privacy
  get '/tos', to: 'pages#show', page: :tos, as: :tos
  get '/contributing', to: 'pages#show', page: :contributing, as: :contributing

  unless Settings[:omniauth].nil?
    providers = Regexp.union(Settings.omniauth_providers)
    scope via: [:get, :post] do
      match '/auth/failure', to: 'omniauth_callbacks#failure'
      scope protocol: 'https', constraints: { provider: providers } do 
        match '/auth/:provider', to: 'omniauth_callbacks#authorize', as: :omniauth_authorize
        match '/auth/:provider/callback', to: 'omniauth_callbacks#callback', as: :omniauth_callback
      end
    end
  end

  mount Sidekiq::Monitor::Engine, at: '/sidekiq'
  mount Goatmail::App, at: '/inbox' if Rails.env.development?

  match '*path', to: redirect(subdomain: nil, path: '/', status: 301), via: :all
end
