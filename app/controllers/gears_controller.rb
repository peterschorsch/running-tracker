class GearsController < ApplicationController
  before_action :set_gear, only: [:show, :edit, :update, :destroy]

  # GET /gears
  # GET /gears.json
  def index
    @gears = Gear.includes(:shoe_brand).order_by_shoe
    @active_shoes = @gears.active_shoes
    @retired_shoes = @gears.retired_shoes
  end

  # GET /gears/new
  def new
    @gear = Gear.new
  end

  # GET /gears/1/edit
  def edit
  end

  # POST /gears
  # POST /gears.json
  def create
    @gear = Gear.new(gear_params)

    set_gear_fields

    respond_to do |format|
      if @gear.save
        format.html { redirect_to gears_path, notice: "<strong>#{@gear.return_shoe_name}</strong> was successfully created." }
        format.json { render :show, status: :created, location: @gear }
      else
        format.html { render :new }
        format.json { render json: @gear.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gears/1
  # PATCH/PUT /gears/1.json
  def update
    set_gear_fields

    respond_to do |format|
      if @gear.update(gear_params)
        format.html { redirect_to gears_path, notice: "<strong>#{@gear.return_shoe_name}</strong> was successfully updated." }
        format.json { render :index, status: :ok, location: @gear }
      else
        format.html { render :edit }
        format.json { render json: @gear.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gear
      @gear = Gear.find(params[:id])
    end

    def set_gear_fields
      @gear.set_new_default if gear_params[:default]=="1"
      #gear_params[:retired]=="1" ? @gear.retire_shoe : gear_params[:retired_on] = nil
    end

    # Only allow a list of trusted parameters through.
    def gear_params
      params.require(:gear).permit(:model, :color_way, :image, :heel_drop, :weight, :size, :shoe_type, :mileage, :default, :purchased_on, :first_used_on, :retired, :retired_on, :shoe_brand_id)
    end
end