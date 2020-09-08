namespace :database do

	desc "Resets all records in tables"
	task :clean_tables => [:environment] do |t, args|
		if !Rails.env.production?
			start = Time.now
			puts "***STARTED REMOVAL PROCESS***"

			DatabaseCleaner.clean_with :truncation #wipe date

			puts "***SUCCESSFULLY REMOVED DATA PRESENT IN TABLES***"
			puts "***RAN IN " + (Time.now - start).round(1).to_s + " SECONDS***"

		else
			puts "***CANNOT RUN RAKE TASK IN PRODUCTION***"
		end
	end

end
