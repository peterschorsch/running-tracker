class RaceExamplesController < ApplicationController
  before_action :set_race_example, only: [:show, :edit, :update, :destroy]

  # GET /race_examples
  # GET /race_examples.json
  def index
    @race_examples = RaceExample.all
  end

  # GET /race_examples/1
  # GET /race_examples/1.json
  def show
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
        format.html { redirect_to @race_example, notice: 'Race example was successfully created.' }
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
        format.html { redirect_to @race_example, notice: 'Race example was successfully updated.' }
        format.json { render :show, status: :ok, location: @race_example }
      else
        format.html { render :edit }
        format.json { render json: @race_example.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /race_examples/1
  # DELETE /race_examples/1.json
  def destroy
    @race_example.destroy
    respond_to do |format|
      format.html { redirect_to race_examples_url, notice: 'Race example was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race_example
      @race_example = RaceExample.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def race_example_params
      params.fetch(:race_example, {})
    end
end
