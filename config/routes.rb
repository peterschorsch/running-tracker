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

  namespace :admin do
    resources :shoe_brands, path: 'shoe-brands', except: [:new, :edit, :show]
    resources :run_types, path: "run-types", except: [:show]
  end

  resources :gears, path: "shoes", except: [:show, :destroy]
  resources :obligations, except: [:show]
  resources :runs, except: [:show]
  resources :yearly_totals
  resources :monthly_totals
  resources :weekly_totals
  get 'statistics', to: 'statistics#index'
  resources 'calendars', only: [:index] do
    collection do
      get '/edit/:id', to: 'calendars#edit', as: "edit"
      patch '/edit/:id', to: 'calendars#update', as: "update"
      post '/create_current_week_runs', to: 'calendars#create_current_week_runs'
      post '/copy_past_week_runs', to: 'calendars#copy_past_week_runs'
      post '/copy_current_week_runs', to: 'calendars#copy_current_week_runs'
      post '/copy_until_specific_date', to: 'calendars#copy_until_specific_date'
    end
  end
end
