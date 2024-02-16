class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:sign_up, :sign_in]
  # before_action :authenticate_user,only:[:current_user]

  def sign_in
    unless params[:email] && params[:password]
      return render json:{success: false, error:'Invalid request!missing information.'},status: :Bad_Request
    end

    user = User.find_by(email:params[:email])
    if user && user.authenticate(params[:password])
      user.password_digest = nill
      token=JwtToken.sign_in[user_id:user.id]
      render json{ success:true,data:
                                    {
                                     user: user,
                                     accessToken:token,
                                     properties: property.where[user_id:user.id],
                                     reservations: reservation.where[user_id:user.id]
                                    }
                                },status: :ok
    else
      render json:{success: false, error:'Invalid email or password.'},status: :unauthorized
    end
  end

  def current_user
    @my_properties=property.where[user_id:@current_user.id]
    @my_reservations=reservation.where[user_id:@current_user.id]
    render json{ success:true,data:{
                                    myproperties:@my_properties,myreservations:@my_reservations,include:%i[images]
                                  } 
                                },status: :ok
  end

  def sign_up 
    params[:user][:role] = 'user'
    @user=User.new(user_params)
    @user.avatar = 'avatar'
    if @user.save
      token=JsonWebToken.encode(user_id: @user.id)
      # render json: {token: token, user_details: { @user.as_json(except:[:password_digest]}}),status: :created
      render json: { token: token, user_details: @user.as_json(except: [:password_digest]) }, status: :created

    else
      render json:@user.errors,status: :unprocessable_entity
    end
  end
  
private
  def user_params
    params.require(:user).permit(:name, :email, :password_digest, :role)
  end
end
