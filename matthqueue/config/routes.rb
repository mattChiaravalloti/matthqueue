Rails.application.routes.draw do
  root 'welcome#index'

  resources :accounts, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :institutions

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'admin_login' => 'sessions#new_admin'
  post 'admin_login' => 'sessions#create_admin'
end
