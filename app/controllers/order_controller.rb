class OrderController < ApplicationController
    before_filter :validate_order, only: :create

    # View all orders
     def index
        @orders = Order.all
        render json: @orders
    end

    # Create Order
    def create
        @order = Order.new(order_params) # Set new order with the details from the params
        
        if @order.save
            @product = Product.find(@order.product_id) #find the product 
            stock = @product.stock
            stock = stock - @order.quantity_ordered
            @product.stock = stock # Reduce the stock accordingly
            if @product.save # Update the changes
                render json:{message:"Order created", order:@order, product:@product}
            else
                order = Order.find(@order.id) # Find the order if the product throws error
                order.destroy # Destroy the order
                render json: { message: "Error is ", errors: @product.errors.full_messages }
            end
        else
            render json: { message: "Error is ", errors: @order.errors.full_messages }
        end
    end

    #Show Order as per Id
    def show
        @order = Order.find(params[:id])
        render json: @order
    end

    #Show Order list of the User
    def show_user_orders
        @order = Order.where(user_id: params[:id])
        render json: @order
    end

    #Update Order
    def update
        begin
            @order = Order.find(params[:id])
            if @order.update_attributes(order_status: params[:order_status])
                render text: "Order Updated Sucessfully"      
            else
                render json: {errors: @order.errors.full_messages }
            end
          rescue ActiveRecord::RecordNotFound
            render text: "Order Id not found", status: :not_found
          rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    # Delete Order
    def destroy
        begin
            @order = Order.find(params[:id])
            if @order.destroy
              render text: "Order deleted successfully"
            else
              render text: "Error in deleting order"
            end
          rescue ActiveRecord::RecordNotFound
            render text: "Order id not found", status: :not_found
          rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    private
    # Validating while creating the order
    def validate_order
        begin
            user = User.find(params[:user_id])# Finding the user exist
            product = Product.find(params[:product_id]) # Finding if the product exist
            if user && product # Checking whether it is nil
                if product.stock > 7 || product.stock <=0 || product.stock < params[:quantity_ordered].to_i # Checking stock with default value and the quantity_ordered
                    render json: {error:"Stock not available"},status: :not_found
                    return
                end
            end
         rescue ActiveRecord::RecordNotFound
            render text: "User Or Product not found", status: :not_found
         rescue => e
            render text: "An error occurred: #{e.message}", status: :unprocessable_entity
        end
    end

    private
    # Get all the order details from the params
    def order_params
        params.slice(:id, :address, :order_status, :quantity_ordered, :total_price, :delivery_time, :product_id, :user_id)
    end

end
