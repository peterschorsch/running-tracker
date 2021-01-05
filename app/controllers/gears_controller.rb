class GearsController < ApplicationController
  before_action :set_user_shoes, only: [:index]
  before_action :set_gear, only: [:show, :edit, :update, :destroy]
  before_action :viewer_authorization, only: [:create, :update]

  # GET /gears
  # GET /gears.json
  def index
    @active_shoes = @user_shoes.active_shoes
    @retired_shoes = @user_shoes.retired_shoes
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
    @gear.save

    respond_to do |format|
      if check_for_retired_shoe
        format.html { redirect_to gears_path, notice: "<strong>#{@gear.return_full_shoe_name}</strong> was successfully created." }
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
    @gear.update(gear_params)

    respond_to do |format|
      if check_for_retired_shoe
        format.html { redirect_to gears_path, notice: "<strong>#{@gear.return_full_shoe_name}</strong> was successfully updated." }
        format.json { render :index, status: :ok, location: @gear }
      else
        format.html { render :edit }
        format.json { render json: @gear.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def viewer_authorization
      if current_user.is_viewer?
        flash[:alert] = "You are not authorized to do said action."
        redirect_to gears_path
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_gear
      @gear = Gear.find(params[:id])
    end

    def set_user_shoes
      @user_shoes = current_user.gears.includes(:shoe_brand)
    end

    def set_gear_fields
      @gear.user_id = current_user.id
      @gear.remove_other_default_shoes if gear_params[:default]=="1"
    end

    def check_for_retired_shoe
      gear_params[:retired]=="1" ? @gear.retire_shoe : @gear.unretire_shoe
    end

    # Only allow a list of trusted parameters through.
    def gear_params
      params.require(:gear).permit(:model, :color_way, :image, :forefoot_stack, :heel_stack, :heel_drop, :weight, :size, :shoe_type, :mileage, :default, :purchased_on, :first_used_on, :retired, :retired_on, :shoe_brand_id)
    end
end
