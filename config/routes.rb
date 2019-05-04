Rails.application.routes.draw do
  scope '/api/v1' do
    resources :users do
      resources :projects, only: [:index, :create]
    end

    resources :projects, only: [:show, :update, :destroy] do
      resources :tasks, only: [:index, :create]
    end

    resources :tasks, only: [:show, :update, :destroy]
  end
end
