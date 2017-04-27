Rails.application.routes.draw do
  root 'welcome#index'

  # accounts
  resources :accounts, only: [:new, :create, :show, :edit, :update, :destroy]

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
    resources :oh_time_slots, only: [:create, :show] do
      member do
        get :launch_queue
      end
      resources :oh_queues, only: [:show] do
        member do
          get :end_queue
        end
        resources :questions, only: [:create, :update, :destroy]
      end
    end
  end
  post 'create_course' => 'courses#create'
  post 'enroll_course' => 'courses#enroll'
  post 'drop_course' => 'courses#drop'

  # institutions are last because they are least accessed
  resources :institutions

end
