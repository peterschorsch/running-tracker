json.extract! monthly_total, :id, :month_number, :month_start, :month_end, :mileage_total, :hours, :minutes, :seconds, :number_of_runs, :elevation_gain, :created_at, :updated_at
json.url monthly_total_url(monthly_total, format: :json)
