class Api::V1::UserController < ApplicationController
  # before_action :authenticate_user, except: :create
  # load_and_authorize_resource
  # rescue_from :ActiveRecord::RecordNotFound ,with: :user_not_found
  # before_action :set_user , only: %i[show update destroy]
  skip_before_action :verify_authenticity_token, only: [:update, :destroy]  

  def index
    @user = User.all
    render json: @user.as_json(except:[:password_digest])
  end

  def show
    render json: @user.as_json(except:[:password_digest])
  end

  def update
    if @current_user.update(user_params)
      render json: { message: "User information updated successfully", user: @current_user }
    else
      render json: { error: "Validation failed", errors: @user.errors }, status: :unprocessable_entity
    end 
  end

  def destroy
    if @current_user.destroy
      render json: [message: 'user deleted successfully'], status: :no_content
    else
      render json: [message: 'error'], status: :no_content
    end
  end

  private

  def user_not_found
    render json: {error: "No user with id #{params[:id]}"}, status: :not_found
  end

  # def set_user
  #   @user = User.find(params[:id])
  # end

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end

end
