class Admin::ObligationColorsController < Admin::AdminController
  before_action :set_obligation_color, only: [:edit, :update]

  def edit
  end

  def update
    respond_to do |format|
      if @obligation_color.update(obligation_color_params)
        format.html { redirect_to edit_admin_obligation_color_path(@obligation_color), notice: "<strong>#{@obligation_color.name}</strong> was successfully updated." }
        format.json { render :edit, status: :ok, location: @obligation_color }
      else
        format.html { render :edit }
        format.json { render json: @obligation_color.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_obligation_color
      @obligation_color = ObligationColor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def obligation_color_params
      params.require(:obligation_color).permit(:name, :hex_code)
    end
end
