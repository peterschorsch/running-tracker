class Admin::RaceExamplesController < ApplicationController
  before_action :set_race_example, only: [:show, :edit, :update, :destroy]

  # GET /race_examples
  # GET /race_examples.json
  def index
    @race_distances = RaceExample.includes(:race_distance).group_by_distance
  end

  # GET /race_examples/new
  def new
    @race_example = RaceExample.new
  end

  # GET /race_examples/1/edit
  def edit
  end

  # POST /race_examples
  # POST /race_examples.json
  def create
    @race_example = RaceExample.new(race_example_params)

    respond_to do |format|
      if @race_example.save
        format.html { redirect_to admin_race_examples_path, notice: "<strong>#{@race_example.name}</strong> was successfully updated." }
        format.json { render :show, status: :created, location: @race_example }
      else
        format.html { render :new }
        format.json { render json: @race_example.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /race_examples/1
  # PATCH/PUT /race_examples/1.json
  def update
    respond_to do |format|
      if @race_example.update(race_example_params)
        format.html { redirect_to admin_race_examples_path, notice: "<strong>#{@race_example.name}</strong> was successfully updated." }
        format.json { render :show, status: :ok, location: @race_example }
      else
        format.html { render :edit }
        format.json { render json: @race_example.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race_example
      @race_example = RaceExample.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def race_example_params
      params.require(:race_example).permit(:name, :hours, :minutes, :seconds, :pace, :elevation_gain, :city, :state_id, :race_distance_id)
    end
end
