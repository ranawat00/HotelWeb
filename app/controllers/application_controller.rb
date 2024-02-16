
class ApplicationController < ActionController::Base
# include Jwt token
# include CanCan ControllerAdditions

# recuse_form CanCan::AccessDenied, with: :unauthorized_user
# def not_found
#   render json: { error: 'Route not found' }, status: :not_found
# end
# protected

#   def authenticate_user
#     header=request.headers['Authorization']
#     token=header.split.last if header 
#     begin 
#       curr_time=time.now
#       if curr_time>@decoded[:exp]
#         return render json {sucess:false, error:'Invalid token!'},status: :unauthorized
#       end

#       @current_user=User.find(@decode[:user.id])
#       @current_user.password_digest=nil
#     rescue ActiveRecord::RecordNotFound => e
#         render json: {sucess: false ,error: e.message},  ststus: :unauthorized
#     rescue Dwt::DecodeError => e
#         render json:{success:false, error: 'Invalid token'} ,status: :unauthorized
#     end #{e.message
#   end 

#   attr_reader :current_user 

#   def unauthorized_user (_exception)
#     render json: { success: false, error: 'Unauthorized access denied' }, status: :unauthorized
#   end
end