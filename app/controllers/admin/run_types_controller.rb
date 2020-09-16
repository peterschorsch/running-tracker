class Admin::RunTypesController < Admin::AdminController
  before_action :set_run_type, only: [:edit, :update, :destroy]

  # GET /run_types
  # GET /run_types.json
  def index
    @active_run_types = RunType.active_run_types
    @removed_run_types = RunType.removed_run_types
  end

  # GET /run_types/new
  def new
    @run_type = RunType.new
  end

  # GET /run_types/1/edit
  def edit
  end

  # POST /run_types
  # POST /run_types.json
  def create
    @run_type = RunType.new(run_type_params)

    respond_to do |format|
      if @run_type.save
        @run_type.update_default_shoe(params[:run_type][:default].to_i)

        format.html { redirect_to admin_run_types_path, notice: "<strong>#{@run_type.name}</strong> was successfully created." }
        format.json { render :index, status: :created, location: @run_type }
      else
        format.html { render :new }
        format.json { render json: @run_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /run_types/1
  # PATCH/PUT /run_types/1.json
  def update
    respond_to do |format|
      if @run_type.update(run_type_params)
        @run_type.update_default_shoe(params[:run_type][:default].to_i)

        format.html { redirect_to admin_run_types_path, notice: "<strong>#{@run_type.name}</strong> was successfully updated." }
        format.json { render :index, status: :ok, location: @run_type }
      else
        format.html { render :edit }
        format.json { render json: @run_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /run_types/1
  # DELETE /run_types/1.json
  def destroy
    @run_type.remove_action_set_new_default

    respond_to do |format|
      if @run_type.save
        format.html { redirect_to admin_run_types_path, notice: "<strong>#{@run_type.name}</strong> was successfully removed." }
        format.json { render :index, status: :ok, location: @run_type }
      else
        format.html { render :edit }
        format.json { render json: @run_type.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run_type
      @run_type = RunType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def run_type_params
      params.require(:run_type).permit(:name, :hex_code, :active, :default)
    end
end
