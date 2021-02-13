class User::ShoesController < User::UsersController
  before_action :set_shoe, only: [:show, :edit, :update, :destroy]
  before_action only: [:create, :update] do
    website_viewer_authorization(user_shoes_path)
  end

  def index
    @all_user_shoes = current_user.shoes.includes(:shoe_brand)
    @active_shoes = @all_user_shoes.active_shoes
    @retired_shoes = @all_user_shoes.retired_shoes
  end

  def new
    @shoe = Shoe.new
  end

  def edit
  end

  def create
    @shoe = Shoe.new(shoe_params)

    set_shoe_fields
    @shoe.save

    respond_to do |format|
      if check_for_retired_shoe
        format.html { redirect_to user_shoes_path, notice: create_notice(@shoe.return_full_shoe_name) }
        format.json { render :show, status: :created, location: @shoe }
      else
        format.html { render :new }
        format.json { render json: @shoe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    set_shoe_fields
    @shoe.update(shoe_params)

    respond_to do |format|
      if check_for_retired_shoe
        format.html { redirect_to user_shoes_path, notice: update_notice(@shoe.return_full_shoe_name) }
        format.json { render :index, status: :ok, location: @shoe }
      else
        format.html { render :edit }
        format.json { render json: @shoe.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shoe
      @shoe = current_user.shoes.find(params[:id])
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
