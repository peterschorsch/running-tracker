class User::ObligationsController < User::UsersController
  before_action :set_obligation, only: [:edit, :update, :destroy]
  before_action :set_end_time, only: [:create, :update]

  before_action do
    website_viewer_authorization(dashboards_path)
  end

  def index
    @obligations = current_user.obligations.order_by_newest_date_time.includes(:state)
  end

  def new
    @obligation = Obligation.new
  end

  def edit
  end

  def create
    @obligation = Obligation.new(obligation_params)

    @obligation.user_id = current_user.id
    @obligation.obligation_color_id = ObligationColor.default_record.id

    respond_to do |format|
      if @obligation.save
        format.html { redirect_to user_obligations_path, notice: create_notice(@obligation.name) }
        format.json { render :index, status: :created, location: @obligation }
      else
        format.html { render :new }
        format.json { render json: @obligation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @obligation.update(obligation_params)
        format.html { redirect_to user_obligations_path, notice: update_notice(@obligation.name) }
        format.json { render :index, status: :ok, location: @obligation }
      else
        format.html { render :edit }
        format.json { render json: @obligation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @obligation.destroy
    respond_to do |format|
      format.html { redirect_to user_obligations_path, notice: remove_notice(@obligation.name) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_obligation
      @obligation = current_user.obligations.find(params[:id])
    end

    def set_end_time
      @obligation.end_time = nil if not params[:check_end_time].nil?
    end

    # Only allow a list of trusted parameters through.
    def obligation_params
      params.require(:obligation).permit(:name, :start_time, :end_time, :check_end_time, :city, :state_id, :country_id)
    end
end
