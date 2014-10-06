Rails.application.routes.draw do
  root to: "users#index"
  resources :users, only: [:index, :show, :new, :create] do
    resources :goals, only: [:show]
  end
  resources :goals, except: [:index, :new, :show]

  resource :session, only: [:new, :create, :destroy]
end
