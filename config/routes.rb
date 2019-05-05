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
    end
  end
end
