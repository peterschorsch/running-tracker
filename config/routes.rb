Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new', as: "login"

  get 'dashboard', to: 'application#dashboard'
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  ### USERS PAGE ###
  resources :users, except: [:index, :new, :create, :show, :destroy] do
    collection do
      patch 'update_password'
    end
  end

  resources :gears, path: "shoes", except: [:show, :destroy]
  resources :run_types, path: "run-types"
  resources :obligations, except: [:show]
  resources :race_distances, path: "race-distances", except: [:show]
  resources :races, except: [:show]
  resources :yearly_totals
  resources :monthly_totals
  resources :weekly_totals
end
