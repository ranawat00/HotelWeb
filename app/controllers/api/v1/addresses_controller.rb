class Api::V1::AddressesController < ApplicationController
  before_action :set_address,only: %i[create, update]
  skip_before_action :verify_authenticity_token, only: :create


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

  def destroy
    @address.destroy
    head :no_content
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:house_number,:street, :city, :state, :zip_code, :country,:property_id)
  end
end
