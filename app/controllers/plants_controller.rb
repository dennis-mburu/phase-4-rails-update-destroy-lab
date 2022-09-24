class PlantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_json_error_response

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = Plant.find_by(id: params[:id])
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  # PATCH/PUT '/plants/:id'
  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant, status: 202
  end

  # DELETE "/plants/:id"
  def destroy
    plant = find_plant
    plant.destroy
    head 204
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_plant
    Plant.find(params[:id])
  end

  def render_json_error_response
    render json: {error: "Plant not found"}, status: 404
  end

end
