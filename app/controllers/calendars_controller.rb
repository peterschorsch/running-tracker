class CalendarsController < ApplicationController
	before_action :set_run, only: [:edit, :update]

	def index
		#@obligations = Obligation.all.includes(:state) 
		@runs = Run.of_user(current_user).includes(:run_type, :gear)
		@run_types = RunType.active_run_types.order_by_name
	end

	def edit
	end

	def update
		@run.user_id = current_user.id
		@run.gear.update_mileage_of_shoe(@run.id, params[:run][:mileage_total].to_f)
		@run.user.all_time_total.update_all_time_totals

		respond_to do |format|
			if @run.update(run_params)
				format.html { redirect_to calendars_path, notice: "<strong>#{@run.name}</strong> was successfully updated." }
				format.json { render :index, status: :ok, location: @run }
			else
				format.html { render :edit }
				format.json { render json: @run.errors, status: :unprocessable_entity }
			end
		end
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
				format.html { redirect_to request.referrer, notice: "<strong>Last Week's</strong> runs were copied to the current week starting <strong>#{DateTime.now.beginning_of_week.strftime("%B %-d, %Y")}.</strong>" }
			else
				format.html { redirect_to request.referrer, errors: @usergroup.errors }
			end
		end
	end

	### COPY CURRENT WEEK'S RUNS TO NEXT WEEK
	def copy_current_week_runs
		respond_to do |format|
			if Run.copy_current_weeks_runs(current_user)
				format.html { redirect_to request.referrer, notice: "<strong>Last Week's</strong> runs were copied to the current week starting <strong>#{(DateTime.now+1.week).beginning_of_week.strftime("%B %-d, %Y")}.</strong>" }
			else
				format.html { redirect_to request.referrer, errors: @usergroup.errors }
			end
		end
	end

	def copy_until_specific_date
		end_date = params[:end_date]
		if end_date.present?
			end_date = end_date.to_datetime
			respond_to do |format|
				if Run.copy_until_specific_date(current_user, end_date)
					flash[:notice] = "<strong>Current Week's</strong> runs were copied to the week ending <strong>#{(end_date).end_of_week.strftime("%B %-d, %Y")}.</strong>"
					format.js { }
				else
					format.html { render :index }
				end
			end
		end
	end

	private
		def set_run
			@run = Run.of_user(current_user).find(params[:id])
		end

		def run_params
	      params.require(:run).permit(:name, :completed_run, :planned_mileage, :mileage_total, :start_time, :hours, :minutes, :seconds, :pace, :elevation_gain, :city, :notes, :personal_best, :gear_id, :state_id, :run_type_id)
	    end

end
