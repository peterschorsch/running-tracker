Rails.application.routes.draw do
  resources :race_examples
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#root_page'
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  ### HOME PAGE ###
  resources 'dashboards', path: "dashboard", only: [:index] do
    collection do
      patch 'weekly_total/:id', to: 'dashboards#update', as: "update"
    end
  end

  ### HEADER ###
  resources 'calendars', only: [:index] do
    collection do
      get '/edit/:id', to: 'calendars#edit', as: "edit"
      patch '/edit/:id', to: 'calendars#update', as: "update"
      delete '/destroy/:id', to: 'calendars#destroy', as: "destroy"
      get '/new', to: 'calendars#new'
      post '/new', to: 'calendars#create'
      post '/create_current_week_runs', to: 'calendars#create_current_week_runs'
      post '/copy_past_week_runs', to: 'calendars#copy_past_week_runs'
      post '/copy_current_week_runs', to: 'calendars#copy_current_week_runs'
      post '/copy_until_specific_date', to: 'calendars#copy_until_specific_date'
    end
  end
  resources :runs, except: [:show]
  resources :gears, path: "shoes", except: [:show, :destroy]
  get 'pace-chart', to: 'dashboards#pace_chart'

  ### ADMIN FUNCTIONS ###
  namespace :admin do
    resources :shoe_brands, path: 'shoe-brands', except: [:new, :edit, :show]
    resources :run_types, path: "run-types", except: [:show]
  end

  ### USERS PAGE ###
  resources :users, except: [:index, :new, :create, :show, :destroy] do
    collection do
      patch 'update_password'
    end
  end
  resources :statistics, only: [:index] do
    collection do
      post :refresh, to: 'statistics#refresh_stats'
    end
  end

  get 'race-results', to: 'race_results#index'
  resources :obligations, except: [:show]
end
