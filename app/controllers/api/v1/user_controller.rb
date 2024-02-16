class Api::V1::UserController < ApplicationController
  before_action :authenticate_user, except: :create
  # load_and_authorize_resource
  rescue_from :ActiveRecord::RecordNotFound ,with: :user_not_found
  before_action :set_user , only: %i[show update destroy]


  def index
    @users = User.all
    render json: @users.as_json(except:[:password_digest])
  end

  def show
    render json: @user.as_json(except:[:password_digest])
  end

  # def create
  #   user_params[:role]='user'

  #   @user = User.new(user_params)
  #   if @user.save
  #     render json: @user.as_json(except:[:password_digest]),status: :created
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end 
  # end

  def update
    if @user.update(user_params)
      render json: @user.as_json(except:[:password_digest])

    else
      render json: @user.errors, status: :unprocessable_entity
    end 
  end

  def destroy
    @user.destroy
    render json: [message: 'user deleted successfully'], status: :no_content
  end

  private

  def user_not_found
    render json: {error: "No user with id #{params[:id]}"}, status: :not_found
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end






end
