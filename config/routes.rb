Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#new', as: "login"

  #get "/login", to: "sessions#new"
  get 'dashboard', to: 'application#dashboard'
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  ### USERS PAGE ###
    resources :users, except: [:index, :new, :create, :show, :destroy] do
      collection do
        patch 'update_password'
      end
    end
end
