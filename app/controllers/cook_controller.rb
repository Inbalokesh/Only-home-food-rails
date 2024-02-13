class CookController < ApplicationController
    # View all cooks
    def index
        @cooks = Cook.all
        render json: @cooks
      end

    # Create cook
    def create
        @cook = Cook.new(cook_params)
    
        if @cook.save
            render json:{message:"cook created", cook:@cook}
        else
            render json: { message: "Error is ", errors: @cook.errors.full_messages }
        end
    end

    #Show cook as per Id
    def show
        begin
          @cook = Cook.find(params[:id])
          render json: @cook
         rescue ActiveRecord::RecordNotFound
            render text: "Cook Id not found", status: :not_found
         rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    #Update cook
    def update
        begin
            @cook = Cook.find(params[:id])
            if @cook.update_attributes(params[:cook])
                render text: "Cook Updated Sucessfully"      
            else
                render json: {errors: @cook.errors.full_messages }
            end
          rescue ActiveRecord::RecordNotFound
            render text: "Cook Id not found", status: :not_found
          rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    # Delete cook
    def destroy
        begin
            @cook = Cook.find(params[:id])
            if @cook.destroy
              render text: "Cook deleted successfully"
            else
              render text: "Error in deleting cook"
            end
          rescue ActiveRecord::RecordNotFound
            render text: "cook id not found", status: :not_found
          rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    private
    # Get all the cook details from the params
    def cook_params
        params.slice(:first_name, :last_name, :email)
    end

end
