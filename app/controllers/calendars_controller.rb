class CalendarsController < ApplicationController
	def index
		#@obligations = Obligation.all.includes(:state) 
		@runs = Run.of_user(current_user).includes(:run_type, :gear)
		@run_types = RunType.active_run_types.order_by_name
	end

	### CREATE DEFAULT RUNS FOR CURRENT WEEK
	def create_current_week_runs
		respond_to do |format|
			if Run.create_weeklong_default_runs(current_user.id)
				format.html { redirect_to request.referrer, notice: "<strong>Default Runs</strong> were created for the week starting <strong>#{DateTime.now.beginning_of_week.strftime("%B %-d, %Y")}.</strong>" }
			else
				format.html { redirect_to request.referrer, errors: @usergroup.errors }
			end
		end
	end

	### COPY LAST WEEK'S RUNS TO CURRENT WEEK
	def copy_past_week_runs
		respond_to do |format|
			if Run.copy_last_weeks_runs(current_user)
				format.html { redirect_to request.referrer, notice: "<strong>Last Week's</strong> runs were copy to the current week starting <strong>#{DateTime.now.beginning_of_week.strftime("%B %-d, %Y")}.</strong>" }
			else
				format.html { redirect_to request.referrer, errors: @usergroup.errors }
			end
		end
	end

	### COPY CURRENT WEEK'S RUNS TO NEXT WEEK
	def copy_current_week_runs
		respond_to do |format|
			if Run.copy_current_weeks_runs(current_user)
				format.html { redirect_to request.referrer, notice: "<strong>Last Week's</strong> runs were copy to the current week starting <strong>#{(DateTime.now+1.week).beginning_of_week.strftime("%B %-d, %Y")}.</strong>" }
			else
				format.html { redirect_to request.referrer, errors: @usergroup.errors }
			end
		end
	end

end
