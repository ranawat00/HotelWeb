class Api::V1::AddressesController < ApplicationController
  before_action :set_address,only: %i[create, update]

  def create
    @address = Address.new(address_params)
    if @address.save
      render json: @address, status: :created
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end 

  def update
    if @address.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def address_params
    params.require(:address).permit(:house_number,:street, :city, :state, :zip_code, :country,:property_id)
  end
end
