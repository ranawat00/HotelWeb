class Api::V1::PropertiesController < ApplicationController
  # before_action :set_default_respons_format
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]  

  def index
    @properties = Property.joins(:reservation_criteria).distinct
    render json: @properties, include: %i[reservation_criteria category images address]
  end

  def show
    @property = Property.find(params[:id])
    render json: @property, include: %i[reservation_criteria category images address]
  end 

  def create
    @property = Property.new(property_params)
    # @property.user_id = current_user.id if current_user
    if @property.save
      if params[:images].present?
        params[:images].each do |image|
          @property.images.create(source: image_source)
        end
      end
      render json: @property,status: :created
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def update
      @property = Property.find(params[:id])
      if@property.update(property_params)
      render json: @property, include: %i[user reservation_criteria category images address]
    else 
      render json: @property.errors, status: :unprocessable_entity
    end 
  end 

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
  end 

  private

  def property_params
    params.require(:property).permit(:name, :description, :no_bedrooms, :no_baths, :no_beds, :area, :category_id,images:[])
  end 

  def set_default_response_format
    request.format = :json
  end 

  def record_not_found
    render json: {error: "Record not found", status: :not_found}, status: :not_found
  end 
end
