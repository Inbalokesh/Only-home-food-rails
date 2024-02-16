class UsersController < ApplicationController
    skip_before_filter :check_is_admin, only: [:create, :update, :show]
    # View all users
    def index
        @users = User.all
        render json: {users:@users}
    end

    # Create user
    def create
        @user = User.new(user_params)
        @user.is_admin = false
        if @user.save
            render json:{message:"User created", user: @user}
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
        begin 
            @user = User.find(params[:id])
            render json: @user
         rescue ActiveRecord::RecordNotFound
            render text: "User Id not found", status: :not_found
         rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    #Update User
    def update
        begin
            @user = User.find(params[:id])
            if @user.update_attributes(name: params[:name])
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

    # Make Admin
    def make_admin
        begin
            user = User.find(params[:id])
            if user.is_admin
                render text: "He is already an admin"
            else
                if user.update_attributes(is_admin: true)
                    render json: {Message:"#{user.name} is admin now"}
                else
                    render json: {Error:user.errors.full_messages, status:"not found"}
                end
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
        params.slice(:name, :mobile_number, :password, :is_admin, :email)
    end
end
