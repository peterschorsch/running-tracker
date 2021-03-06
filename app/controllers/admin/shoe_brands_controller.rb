class Admin::ShoeBrandsController < Admin::AdminController
  before_action :set_admin_shoe_brand, only: [:update, :destroy]

  # GET /admin/shoe_brands
  # GET /admin/shoe_brands.json
  def index
    @admin_shoe_brands = ShoeBrand.all
    @new_admin_shoe_brand = ShoeBrand.new
  end

  # POST /admin/shoe_brands
  # POST /admin/shoe_brands.json
  def create
    @admin_shoe_brand = ShoeBrand.new(admin_shoe_brand_params)

    respond_to do |format|
      if @admin_shoe_brand.save
        format.html { redirect_to admin_shoe_brands_path, notice: create_notice(@admin_shoe_brand.brand) }
        format.json { render :index, status: :created, location: @admin_shoe_brand }
      else
        format.html { redirect_to admin_shoe_brands_path, alert: "You " + bold_text("MUST") + " provide a brand name." }
      end
    end
  end

  # PATCH/PUT /admin/shoe_brands/1
  # PATCH/PUT /admin/shoe_brands/1.json
  def update
    respond_to do |format|
      if @admin_shoe_brand.update(admin_shoe_brand_params)
        format.html { redirect_to admin_shoe_brands_path, notice: update_notice(@admin_shoe_brand.brand) }
        format.json { render :index, status: :ok, location: @admin_shoe_brand }
      else
        format.html { redirect_to admin_shoe_brands_path, alert: "Validation Error" }
      end
    end
  end

  # DELETE /admin/shoe_brands/1
  # DELETE /admin/shoe_brands/1.json
  def destroy
    @default_shoe = Gear.return_default_shoe
    @admin_shoe_brand.shoes.each do |shoe|
      shoe.runs.each do |run|
        @default_shoe.add_mileage_to_shoe(run.mileage_total)
        run.shoe_id = @default_shoe.id
        run.shoe.save(:validate => false)
        run.save(:validate => false)
      end
    end

    @admin_shoe_brand.destroy
    respond_to do |format|
      format.html { redirect_to admin_shoe_brands_path, notice: remove_notice(@admin_shoe_brand.brand) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_shoe_brand
      @admin_shoe_brand = ShoeBrand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_shoe_brand_params
      params.require(:shoe_brand).permit(:brand)
    end
end
