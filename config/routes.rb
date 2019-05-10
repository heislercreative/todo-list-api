Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: [:show, :index, :destroy]
      resources :projects do
        resources :tasks, only: [:index, :create]
      end

      resources :tasks, only: [:update, :destroy]

      get 'user' => 'users#show'
      post 'auth/login' => 'auth#create'
      post '/auth/facebook' => 'auth#create_fb'
      delete 'auth/logout' => 'auth#destroy'
    end
  end
end
