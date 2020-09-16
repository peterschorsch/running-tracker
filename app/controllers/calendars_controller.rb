class CalendarsController < ApplicationController
	def index
		#@obligations = Obligation.all.includes(:state) 
		@runs = Run.all.includes(:run_type, :gear)
		@run_types = RunType.active_run_types.order_by_name
	end

	def create_current_week_runs
		respond_to do |format|
			if Run.create_weeklong_default_runs(current_user.id)
				format.html { redirect_to request.referrer, notice: "<strong>Default Runs</strong> were created for the week starting <strong>#{DateTime.now.beginning_of_week.strftime("%B %-d, %Y")}.</strong>" }
			else
				format.html { redirect_to request.referrer, errors: @usergroup.errors }
			end
		end
	end

end
