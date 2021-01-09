class ShoesController < ApplicationController
  before_action :set_user_shoes, only: [:index]
  before_action :set_shoe, only: [:show, :edit, :update, :destroy]
  before_action :viewer_authorization, only: [:create, :update]

  # GET /shoes
  # GET /shoes.json
  def index
    @active_shoes = @user_shoes.active_shoes
    @retired_shoes = @user_shoes.retired_shoes
  end

  # GET /shoes/new
  def new
    @shoe = Shoe.new
  end

  # GET /shoes/1/edit
  def edit
  end

  # POST /shoes
  # POST /shoes.json
  def create
    @shoe = Shoe.new(shoe_params)

    set_shoe_fields
    @shoe.save

    respond_to do |format|
      if check_for_retired_shoe
        format.html { redirect_to shoes_path, notice: "<strong>#{@shoe.return_full_shoe_name}</strong> was successfully created." }
        format.json { render :show, status: :created, location: @shoe }
      else
        format.html { render :new }
        format.json { render json: @shoe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shoes/1
  # PATCH/PUT /shoes/1.json
  def update
    set_shoe_fields
    @shoe.update(shoe_params)

    respond_to do |format|
      if check_for_retired_shoe
        format.html { redirect_to shoes_path, notice: "<strong>#{@shoe.return_full_shoe_name}</strong> was successfully updated." }
        format.json { render :index, status: :ok, location: @shoe }
      else
        format.html { render :edit }
        format.json { render json: @shoe.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def viewer_authorization
      if current_user.is_viewer?
        flash[:alert] = "You are not authorized to do said action."
        redirect_to shoes_path
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_shoe
      @shoe = current_user.shoes.find(params[:id])
    end

    def set_user_shoes
      @user_shoes = current_user.shoes.includes(:shoe_brand)
    end

    def set_shoe_fields
      @shoe.user_id = current_user.id
      @shoe.remove_other_default_shoes if shoe_params[:default]=="1"
    end

    def check_for_retired_shoe
      shoe_params[:retired]=="1" ? @shoe.retire_shoe : @shoe.unretire_shoe
    end

    # Only allow a list of trusted parameters through.
    def shoe_params
      params.require(:shoe).permit(:model, :color_way, :image, :forefoot_stack, :heel_stack, :heel_drop, :weight, :size, :shoe_type, :previous_mileage, :new_mileage, :default, :purchased_on, :first_used_on, :retired, :retired_on, :shoe_brand_id)
    end
end
