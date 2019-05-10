Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: [:index] do
        resources :projects, only: [:index, :create]
      end

      resources :projects, only: [:show, :update, :destroy] do
        resources :tasks, only: [:index, :create]
      end

      resources :tasks, only: [:update, :destroy]

      post 'auth/login' => 'auth#create'
      get '/auth/facebook/callback' => 'auth#create'
      delete 'auth/logout' => 'auth#destroy'
    end
  end
end
