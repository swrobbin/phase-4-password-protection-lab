class SessionsController < ApplicationController
    # POST /login
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json:{error:{login: "Invalid username and password"}}, status: :unauthorized
        end
    end

    def destroy
        session.delete(:user_id)
        head :no_content
    end


end
