class Api::V1::ReservationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]  
  before_action :set_reservation, only: %i[show update destroy]
  before_action :authenticate_user

  def index
    @reservations = Reservation.all
    render json: @reservations
  end 

  def show
    render json: @reservation
  end

  def create
    @reservation = @current_user.reservations.new(reservation_params)
    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def update
    if @current_user.reservations&.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end 

  def destroy
    if @current_user.reservations
    render json: { message: 'User deleted successfully' }, status: :ok
    else
      render json: { message: 'User not deleted' }, status: :ok
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end 

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :guests, :property_id)
  end
end
