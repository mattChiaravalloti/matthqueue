Rails.application.routes.draw do
  root 'welcome#index'

  # accounts and institutions
  resources :accounts, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :institutions

  # login paths
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'admin_login' => 'sessions#new_admin'
  post 'admin_login' => 'sessions#create_admin'

  # courses
  resources :courses, only: [:show, :destroy] do
    member do
      post :add_instructor
    end
    resources :oh_time_slots, only: [:create, :show, :edit, :update, :destroy]
  end
  post 'create_course' => 'courses#create'
  post 'enroll_course' => 'courses#enroll'
  post 'drop_course' => 'courses#drop'

end
