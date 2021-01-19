Rails.application.routes.draw do
  namespace :admin do
    namespace :total_record do
      resources :monthly_totals
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#root_page'
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  #delete "/sessions", to: "sessions#destroy"
  get 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  # For session timeout
  get 'active'  => 'sessions#active'
  get 'timeout' => 'sessions#timeout'

  ### HOME PAGE ###
  resources 'dashboards', path: "dashboard", only: [:index] do
    collection do
      patch 'weekly_total/:id', to: 'dashboards#update', as: "update"
    end
  end

  ### HEADER ###
  resources 'calendars', only: [:index], path: "calendar" do
    collection do
      get ':id/edit', to: 'calendars#edit', as: "edit"
      patch ':id/edit', to: 'calendars#update', as: "update"
      delete ':id/destroy', to: 'calendars#destroy', as: "destroy"
      get '/new', to: 'calendars#new'
      post '/new', to: 'calendars#create'
      post '/create_current_week_runs', to: 'calendars#create_current_week_planned_runs'
      post '/copy_past_week_runs', to: 'calendars#copy_past_week_runs'
      post '/copy_current_week_runs', to: 'calendars#copy_current_week_runs'
      post '/copy_until_specific_date', to: 'calendars#copy_until_specific_date'
    end
  end

  get 'workout-pace-chart', to: 'pace_charts#workout_pace_chart'
  get 'race-pace-chart', to: 'pace_charts#race_pace_chart'

  ### ADMIN FUNCTIONS ###
  namespace :admin do
    resources :race_examples, path: "race-examples", except: [:show, :destroy]
    resources :race_distances, path: "race-distances", only: [:edit, :update]
    resources :run_types, path: "run-types", except: [:show]
    resources :shoe_brands, path: 'shoe-brands', except: [:new, :edit, :show]
    resources :user_roles, path: "user-roles", except: [:show, :destroy]

    namespace :total_record, path: 'total-records' do
      root to: 'total_records#index'
      resources :yearly_totals, path: 'yearly-totals', only: [:edit, :update]
      resources :monthly_totals, path: 'monthly-totals', only: [:edit, :update]
    end
  end

  resources :runs, except: [:show]
  resources :shoes, path: "shoes", except: [:show, :destroy]
  resources :obligations, except: [:show]

  ### USERS PAGE ###
  resources :users, except: [:index, :new, :create, :show, :destroy] do
    collection do
      patch 'update_password'
    end
  end

  get 'race-results', to: 'race_results#index'

  resources :statistics, only: [:index] do
    collection do
      post :recalculate, to: 'statistics#recalculate_stats'
    end
  end

end
