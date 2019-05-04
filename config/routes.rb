Rails.application.routes.draw do
  scope '/api/v1' do
    resources :tasks
    resources :projects
    resources :users
  end
end
