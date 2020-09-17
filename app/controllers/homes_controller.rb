class HomesController < ApplicationController

	def dashboard
		@runs = Run.of_user(current_user).includes(:run_type)
		@last_run = @runs.find_last_completed_run
		@next_run = @runs.find_next_run
	end

end
