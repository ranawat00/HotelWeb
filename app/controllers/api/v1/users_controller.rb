class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user, only: :destroy
  skip_before_action :verify_authenticity_token, only: [:update, :destroy]  

  def index
    @users = User.all
    if @users.present?
      render json: @users.as_json(except:[:password_digest]), status: :ok
    else
      render json: {error: "No users found"}, status: :not_found
    end 
  end

  def show
    if @user.present?
    render json: @user.as_json(except:[:password_digest]), status: :ok
    else 
      render json: {error: "User not found"}, status: :not_found
    end 
  end

  def update
    if @current_user.update(user_params)
      render json: { message: "User information updated successfully", user: @current_user }
    else
      render json: { error: "Validation failed", errors: @user.errors }, status: :unprocessable_entity
    end 
  end

  def destroy
    unless @current_user 
      return render json: { message: "User Not Found" }, status: :not_found
    end
    if @current_user.delete
      render json: { message: 'User deleted successfully' }, status: :ok
    else
      render json: { message: 'User not deleted' }, status: :ok
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





