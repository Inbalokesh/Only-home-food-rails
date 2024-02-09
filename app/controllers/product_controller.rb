class ProductController < ApplicationController
    before_filter :validate_product, only: [:create, :update]

    # View all products
    def index
        @products = Product.all
        render json: @products
    end

    # Create product
    def create
        @product = Product.new(product_params) # Set new product with the details from the params
    
        if @product.save
            render json:{message:"Product created", product:@product}
        else
            render json: { message: "Error is ", errors: @product.errors.full_messages }
        end
    end

    #Show Food as per Id
    def show
        @product = Product.find(params[:id])
        render json: @product
    end

    #Show Food list of the Cook
    def show_cook_foods
        @product = Product.where(cook_id: params[:id])
        render json: @product
    end

    #Update Product
     def update
        begin
            @product = Product.find(params[:id])
            if @product.update_attributes(params[:product])
                render text: "Product Updated Sucessfully"      
            else
                render json: {errors: @product.errors.full_messages }
            end
          rescue ActiveRecord::RecordNotFound
            render text: "Product Id not found", status: :not_found
          rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    # Delete Product
    def destroy
        begin
            @product = Product.find(params[:id])
            if @product.destroy
              render text: "Product deleted successfully"
            else
              render text: "Error in deleting product"
            end
          rescue ActiveRecord::RecordNotFound
            render text: "Product id not found", status: :not_found
          rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    private
    # Validating while create the product
    def validate_product
        begin
            cook = Cook.find(params[:cook_id]) # Finding if the cook exist
            exist = Product.where(name: params[:name], cook_id: cook.id).first #Finding if the cook has the product already!!
            if exist && exist.cook_id && (params[:id].to_i != exist.id)# exist is checked for nil, Next two checks already food exist but not the same editing item
                render text: "Item already in list"
                return
            end
         rescue ActiveRecord::RecordNotFound
            render text: "Cook Id not found", status: :not_found
         rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    private
    # Get all the product details from the params
    def product_params
        params.slice(:id, :name, :food_type, :quantity_type, :quantity, :stock, :price, :cook_id)
    end
end