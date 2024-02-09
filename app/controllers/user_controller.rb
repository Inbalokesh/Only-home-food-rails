class UserController < ApplicationController

    # View all users
    def index
        @users = User.all
        render json: @users
    end

    # Create user
    def create
        @user = User.new(user_params)
    
        if @user.save
            render json:{message:"user created", user:@user}
        else
            if @user.errors.full_messages.include?("Duplicate entry")
                render json: { message: "Mobile number already exists" }
            else
                render json: { message: "Error is ", errors: @user.errors.full_messages }
            end
        end
    end

    #Show User as per Id
    def show
        @user = User.find(params[:id])
        render json: @user
    end

    #Update User
    def update
        begin
            @user = User.find(params[:id])
            if @user.update_attributes(params[:user])
                render text: "User Updated Sucessfully"      
            else
                render json: {errors: @user.errors.full_messages }
            end
          rescue ActiveRecord::RecordNotFound
            render text: "User Id not found", status: :not_found
          rescue => e
            if e.message.include?("Duplicate entry")
                render json: { message: "Mobile number already exists" }
            else
                render text: "An error occurred: #{e.message}", status: :unprocessable_entity
            end
        end
    end

    # Delete User
    def destroy
        begin
            @user = User.find(params[:id])
            if @user.destroy
              render text: "User deleted successfully"
            else
              render text: "Error in deleting user"
            end
          rescue ActiveRecord::RecordNotFound
            render text: "User id not found", status: :not_found
          rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    private
    # Get all the user details from the params
    def user_params
        params.slice(:name, :mobile_number, :password)
    end
end