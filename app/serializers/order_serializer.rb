class OrderSerializer < ActiveModel::Serializer
    attributes :id, :order_status, :address, :quantity_ordered, :delivery_time, :product_id, :user_id
  end