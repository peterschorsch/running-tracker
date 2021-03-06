class User::RunsController < User::UsersController
  include RunTime

  before_action :set_run, only: [:edit, :update, :destroy]
  before_action only: [:create, :update] do
    set_run_time_fields(current_user, params[:run][:hours], params[:run][:minutes], params[:run][:seconds])
  end
  before_action only: [:create, :update, :destroy] do
    website_viewer_authorization(user_runs_path)
  end

  def index
    @runs = current_user.return_completed_runs.includes(:run_type, shoe: :shoe_brand).order_by_most_recent
  end

  def new
    @run = Run.new
  end

  def edit
  end

  def create
    @run = Run.new(run_params)

    respond_to do |format|
      if @run.save
        format.html { redirect_to user_runs_path, notice: create_notice(@run.name) }
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
        format.html { redirect_to user_runs_path, notice: update_notice(@run.name) }
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
        format.html { redirect_to user_runs_path, notice: remove_notice(@run.name) }
        format.json { render :index, status: :ok, location: @run }
      else
        format.html { render :index }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = current_user.runs.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      flash[:alert] = "You are not authorized to view specified run."
      redirect_to user_runs_path
    end

    # Only allow a list of trusted parameters through.
    def run_params
      params.require(:run).permit(:name, :completed_run, :planned_mileage, :mileage_total, :start_time, :pace_minutes, :pace_seconds, :hours, :minutes, :seconds, :elevation_gain, :city, :notes, :personal_best, :shoe_id, :state_id, :country_id, :run_type_id)
    end

end
