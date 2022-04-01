class CarsController < ApplicationController
  before_action :set_car, only: %i[ show update destroy ]

  # GET /cars
  def index
    @cars = Car.all

    render json: @cars
  end

  # GET /cars/1
  def show
    render json: @car
  end

  # POST /cars
  def create
    @car = Car.new(car_params)
    @car.price = params[:price].split(' ').first.to_i

    if @car.save
      render json: @car, status: :created, location: @car
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  def price_sorted
    sorted_cars = Car.all.order(:price)
    render json: sorted_cars
  end

  def search_by_make
    cars = Car.where(make: params[:make])
    render json: cars
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:id, :make, :model, :price, :photo, :colors =>[], :range => {})
    end
end
