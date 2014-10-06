Rails.application.routes.draw do
  root to: "users#index"

  resources :users, only: [:index, :show, :new, :create] do
    resources :goals, only: [:show]
    resources :user_comments, only: [:create]
  end

  resources :goals, except: [:index, :new, :show] do
    resources :goal_comments, only: [:create]
  end

  resource :session, only: [:new, :create, :destroy]
end
