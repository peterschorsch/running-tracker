class CalendarsController < ApplicationController
	before_action :set_run, only: [:edit, :update, :destroy]
	before_action :viewer_authorization, except: [:index, :edit]

	def index
		@obligations = current_user.obligations.includes(:state, :obligation_color)
		@runs = current_user.runs.includes(:run_type, [shoe: :shoe_brand], :state)
		@run_types = RunType.active_run_types.order_by_name
	end

	def edit
	end

	def new
		@run = Run.new
	end

	def create
		@run = Run.new(run_params)

		### Also, converts and sets hours, minutes, seconds to just seconds ###
    	@run.set_necessary_run_fields(current_user, params[:run][:hours], params[:run][:minutes], params[:run][:seconds])

		respond_to do |format|
			if @run.save
				@run.update_subsequent_tables

				format.html { redirect_to calendars_path, notice: "<strong>#{@run.name}</strong> was successfully created." }
				format.json { render :new, status: :created, location: @run }
			else
				format.html { render :new }
				format.json { render json: @run.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		### Also, converts and sets hours, minutes, seconds to just seconds ###
   		@run.set_necessary_run_fields(current_user, params[:run][:hours], params[:run][:minutes], params[:run][:seconds])

		respond_to do |format|
			if @run.update(run_params)
				@run.update_subsequent_tables

				format.html { redirect_to calendars_path, notice: "<strong>#{@run.name}</strong> was successfully updated." }
				format.json { render :index, status: :ok, location: @run }
			else
				format.html { render :edit }
				format.json { render json: @run.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		respond_to do |format|
			if @run.destroy
				format.html { redirect_to calendars_path, notice: "<strong>#{@run.name}</strong> was successfully removed." }
				format.json { render :index, status: :ok, location: @run }
			else
				format.html { render :index }
				format.json { render json: @run.errors, status: :unprocessable_entity }
			end
		end
	end

	### CREATE PLANNED RUNS FOR CURRENT WEEK
	def create_current_week_planned_runs
		respond_to do |format|
			if current_user.create_weeklong_default_runs
				format.html { redirect_to request.referrer, notice: "<strong>Planned Runs</strong> were created for the week starting <strong>#{DateTime.current.beginning_of_week.strftime("%B %-d, %Y")}.</strong>" }
			else
				format.html { redirect_to request.referrer, errors: @usergroup.errors }
			end
		end
	end

	### COPY LAST WEEK'S RUNS TO CURRENT WEEK
	def copy_past_week_runs
		respond_to do |format|
			if Run.copy_last_weeks_runs(current_user)
				format.html { redirect_to request.referrer, notice: "<strong>Last Week's</strong> runs were copied to the current week starting <strong>#{DateTime.current.beginning_of_week.strftime("%B %-d, %Y")}.</strong>" }
			else
				format.html { redirect_to request.referrer, errors: @usergroup.errors }
			end
		end
	end

	### COPY CURRENT WEEK'S RUNS TO NEXT WEEK
	def copy_current_week_runs
		respond_to do |format|
			if Run.copy_current_weeks_runs(current_user)
				format.html { redirect_to request.referrer, notice: "<strong>This Week's</strong> runs were copied to the next week starting <strong>#{(DateTime.current+1.week).beginning_of_week.strftime("%B %-d, %Y")}.</strong>" }
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
	    def viewer_authorization
	      if current_user.is_viewer?
	        flash[:alert] = "You are not authorized to do said action."
	        redirect_to runs_path
	      end
	    end

	    def set_run
			@run = current_user.runs.return_uncompleted_runs.find(params[:id])
			rescue ActiveRecord::RecordNotFound
			flash[:alert] = "You are not authorized to view specified run."
			redirect_to calendars_path
	    end

	    # Only allow a list of trusted parameters through.
	    def run_params
	      params.require(:run).permit(:name, :completed_run, :planned_mileage, :mileage_total, :start_time, :pace_minutes, :pace_seconds, :hours, :minutes, :seconds, :elevation_gain, :city, :notes, :personal_best, :shoe_id, :state_id, :run_type_id)
	    end

end
