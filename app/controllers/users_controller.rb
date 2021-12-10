class UsersController < ApplicationController
    before_action :authorize
    def show
        user = User.find(params[:id])
        render json: user
    end
    
    def create
        user = User.create(user_params)
        if user.valid?
          session[:user_id] = user.id  
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
      private

      def authorize
        return render json: { error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
      end
    
      def user_params
        params.permit(:username, :password, :password_confirmation)
      end
end
