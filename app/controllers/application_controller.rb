class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_is_admin

  def current_user
    current_user_id = session[:current_user]
    if current_user_id
     @current_user = User.find(current_user_id)
     return @current_user if @current_user
    else
      nil
    end
  end

  private 

  def check_is_admin
    user_id = session[:current_user]
    begin 
      if user_id
        @user = User.find(user_id)
        if @user && @user.is_admin?
          return true
        else
          render json: {Warning: "You are not Authorized"}
          return
        end
      else
        render text: "User must login to continue"
        return
      end
     rescue ActiveRecord::RecordNotFound
      render text: "Invalid user id", status: :not_found
     rescue => e
      render text: "An error occurred: #{e.message}", status: :unprocessable_entity
    end
  end

end
