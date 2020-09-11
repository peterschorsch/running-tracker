json.extract! weekly_total, :id, :week_number, :week_start, :week_end, :mileage_total, :goal, :met_goal, :hours, :minutes, :seconds, :number_of_runs, :elevation_gain, :notes, :created_at, :updated_at
json.url weekly_total_url(weekly_total, format: :json)
