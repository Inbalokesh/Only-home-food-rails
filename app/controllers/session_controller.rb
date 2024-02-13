class SessionController < ApplicationController
    def create
        user = User.find_by_mobile_number(params[:mobile_number])
        if user && user.authenticate(params[:password])
            session[:current_user] = user.id
            render json: {message:"Sucessfully Login", current_user: current_user.id}
        else
            render text: "Invalid login credentails"
        end
    end

    private
    # Get all the user details from the params
    def user_params
        params.slice(:mobile_number, :password)
    end
end
