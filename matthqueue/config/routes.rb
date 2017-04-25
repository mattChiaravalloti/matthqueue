Rails.application.routes.draw do
  root 'welcome#index'

  resources :accounts, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :institutions, only: [:index, :new, :create, :show, :edit, :update]

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
