class User::CalendarsController < User::UsersController
	include RunTime

	before_action :set_run, only: [:edit, :update, :destroy]
	before_action only: [:create, :update] do
		set_run_time_fields(current_user, params[:run][:hours], params[:run][:minutes], params[:run][:seconds])
	end
	before_action except: [:index, :edit] do
		website_viewer_authorization(user_calendars_path)
	end

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

		respond_to do |format|
			if @run.save
				format.html { redirect_to user_calendars_path, notice: create_notice(@run.name) }
				format.json { render :new, status: :created, location: @run }
			else
				format.html { render :new }
				format.json { render json: @run.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @run.update(run_params)
				format.html { redirect_to user_calendars_path, notice: update_notice(@run.name) }
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
				format.html { redirect_to user_calendars_path, notice: remove_notice(@run.name) }
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
				format.html { redirect_to request.referrer, notice: bold_text("Planned Runs") + " were created for the week starting " + bold_text(date_field(DateTime.current.beginning_of_week)) }
			else
				format.html { redirect_to :index }
			end
		end
	end

	### COPY LAST WEEK'S RUNS TO CURRENT WEEK
	def copy_past_week_runs
		respond_to do |format|
			if Run.copy_last_weeks_runs(current_user)
				format.html { redirect_to user_calendars_path, notice: bold_text("This Week's") + " runs were copied to the current week starting " + bold_text(date_field(DateTime.current.beginning_of_week)) }
			else
				format.html { redirect_to :index }
			end
		end
	end

	### COPY CURRENT WEEK'S RUNS TO NEXT WEEK
	def copy_current_week_runs
		respond_to do |format|
			if Run.copy_current_weeks_runs(current_user)
				format.html { redirect_to user_calendars_path, notice: bold_text("This Week's") + " runs were copied to the next week starting " + bold_text(date_field((DateTime.current+1.week).beginning_of_week)) }
			else
				format.html { redirect_to :index }
			end
		end
	end

	def copy_until_specific_date
		end_date = params[:end_date]
		if end_date.present?
			end_date = end_date.to_datetime
			respond_to do |format|
				if Run.copy_until_specific_date(current_user, end_date)
					format.html { redirect_to user_calendars_path, notice: bold_text("Current Week's") + " runs were copied to the week ending " + bold_text(date_field((end_date).end_of_week)) }
				else
					format.html { render :index }
				end
			end
		end
	end

	private
	    def set_run
			@run = current_user.runs.return_uncompleted_runs.find(params[:id])
			rescue ActiveRecord::RecordNotFound
			flash[:alert] = "You are not authorized to view specified run."
			redirect_to user_calendars_path
	    end

	    # Only allow a list of trusted parameters through.
	    def run_params
	      params.require(:run).permit(:name, :completed_run, :planned_mileage, :mileage_total, :start_time, :pace_minutes, :pace_seconds, :hours, :minutes, :seconds, :elevation_gain, :city, :notes, :personal_best, :shoe_id, :state_id, :country_id, :run_type_id)
	    end

end
