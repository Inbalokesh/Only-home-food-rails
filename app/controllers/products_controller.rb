class ProductsController < ApplicationController
    skip_before_filter :check_is_admin, only: [:index, :create, :update, :destroy, :show, :show_cook_foods]
    before_filter :validate_product, only: [:create, :update]

    # View all products
    def index
        if current_user
            puts "Current User ID: #{current_user.id}"
        else
            puts "No User"
        end

        @products = Product.all
        render json: { data: products_json(@products) }
    end

    # Create product
    def create
        @product = Product.new(product_params)
    
        if @product.save
            render json:{message:"Product created", product:@product}
        else
            render json: { message: "Error is ", errors: @product.errors.full_messages }
        end
    end

    #Show Food as per Id
    def show
        begin 
            @product = Product.find(params[:id])
            render json: @product
         rescue ActiveRecord::RecordNotFound
            render text: "Product Id not found", status: :not_found
         rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    #Show Food list of the Cook
    def show_cook_foods
        begin
            if Cook.find(params[:id])
                @product = Product.where(cook_id: params[:id])
                render json: @product
            end
         rescue ActiveRecord::RecordNotFound
            render text: "Cook Id not found", status: :not_found
         rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    #Update Product
    def update
        begin
            @product = Product.find(params[:id])
            if @product.update_attributes(params[:product])
                render json: { data: { message: "Updated Successfully" } }, status: :ok
            else
                render json: { errors: [{ detail: @product.error.full_messages }] }, status: :unprocessable_entity
            end
          rescue ActiveRecord::RecordNotFound
            render json: { errors: [{ detail: "Product Id not found" }] }, status: :not_found
          rescue => e
            render json: { errors: [{ detail: e.message }] }, status: :unprocessable_entity
        end
    end

    # Delete Product
    def destroy
        begin
            @product = Product.find(params[:id])
            if @product.destroy
                render json: { data: { message: "Deleted Successfully" } }, status: :ok
            else
                render json: { errors: [{ detail: "Failed to delete product" }] }, status: :unprocessable_entity
            end
          rescue ActiveRecord::RecordNotFound
            render json: { errors: [{ detail: "Product Id not found" }] }, status: :not_found
        rescue => e
            render json: { errors: [{ detail: e.message }] }, status: :unprocessable_entity
        end
    end

    private
    # Validating while creating the product
    def validate_product
        begin
            cook = Cook.find(params[:cook_id]) # Finding if the cook exist
            exist = Product.where(name: params[:name], cook_id: cook.id).first # Finding if the cook has the product already!!
            if exist && exist.cook_id && (params[:id].to_i != exist.id) # exist is checked for nil, Next two condition checks already food exist but not the same editing item
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

    def products_json(products)
        products.map do |product|
          {
            id: product.id.to_s,
            type: 'products',
            attributes: {
              name: product.name,
              image: product.image,
              food_type: product.food_type,
              stock: product.stock,
              price: product.price,
              quantity: product.quantity,
              quantity_type: product.quantity_type,
              cook_id: product.cook_id
            }
          }
        end
    end

    private
    # Get all the product details from the params
    def product_params
        params.slice(:id, :name, :food_type, :quantity_type, :quantity, :stock, :price, :cook_id, :image)
    end
end
