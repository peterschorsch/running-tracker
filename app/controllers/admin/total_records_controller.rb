class Admin::TotalRecordsController < Admin::AdminController
  before_action :set_user_role, only: [:show, :edit, :update, :destroy]

  def index
    @yearly_totals = current_user.yearly_totals.order_by_recent_year#.includes(:monthly_totals)
  end

  def new
  end

  def edit
  end

  def create
    @user_role = UserRole.new(user_role_params)

    respond_to do |format|
      if @user_role.save
        format.html { redirect_to admin_user_roles_path, notice: "<strong>#{@user_role.name}</strong> was successfully created." }
        format.json { render :index, status: :created, location: @user_role }
      else
        format.html { render :new }
        format.json { render json: @user_role.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user_role.update(user_role_params)
        format.html { redirect_to admin_user_roles_path, notice: "<strong>#{@user_role.name}</strong> was successfully updated." }
        format.json { render :index, status: :ok, location: @user_role }
      else
        format.html { render :edit }
        format.json { render json: @user_role.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_role.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_roles_path, notice: "<strong>#{@user_role.name}</strong> was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_total_record
      @user_role = UserRole.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def yearly_total_params
      params.require(:yearly_total).permit(:name)
    end
    def monthly_total_params
      params.require(:monthly_total).permit(:name)
    end
end
