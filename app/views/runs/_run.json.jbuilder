json.extract! run, :id, :distance, :hours, :minutes, :seconds, :pace, :elevation_gain, :avg_heart_rate, :max_heart_rate, :city, :notes, :personal_best, :created_at, :updated_at
json.url run_url(run, format: :json)
