class ObligationsController < ApplicationController
  before_action :set_obligation, only: [:edit, :update, :destroy]
  before_action :authorized?

  # GET /obligations
  # GET /obligations.json
  def index
    @obligations = current_user.obligations.order_by_newest_date_time.includes(:state)
  end

  # GET /obligations/new
  def new
    @obligation = Obligation.new
  end

  # GET /obligations/1/edit
  def edit
  end

  # POST /obligations
  # POST /obligations.json
  def create
    @obligation = Obligation.new(obligation_params)

    @obligation.user_id = current_user.id
    @obligation.end_time = nil if not params[:check_end_time].nil?
    @obligation.obligation_color_id = ObligationColor.default_record.id

    respond_to do |format|
      if @obligation.save
        format.html { redirect_to obligations_path, notice: "<strong>#{@obligation.name}</strong> was successfully created." }
        format.json { render :index, status: :created, location: @obligation }
      else
        format.html { render :new }
        format.json { render json: @obligation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /obligations/1
  # PATCH/PUT /obligations/1.json
  def update
    @obligation.end_time = nil if not params[:check_end_time].nil?

    respond_to do |format|
      if @obligation.update(obligation_params)
        format.html { redirect_to obligations_path, notice: "<strong>#{@obligation.name}</strong> was successfully updated." }
        format.json { render :index, status: :ok, location: @obligation }
      else
        format.html { render :edit }
        format.json { render json: @obligation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /obligations/1
  # DELETE /obligations/1.json
  def destroy
    @obligation.destroy
    respond_to do |format|
      format.html { redirect_to obligations_path, notice: "<strong>#{@obligation.name}</strong> was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_obligation
      @obligation = current_user.obligations.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def obligation_params
      params.require(:obligation).permit(:name, :start_time, :end_time, :check_end_time, :city, :state_id, :country_id)
    end

    def authorized?
    if current_user.is_viewer?
        session[:user_id] = current_user.id || nil
        flash[:alert] = "You are not authorized to do said action."
        redirect_to dashboards_path
      end
    end
end
