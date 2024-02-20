class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :food_type, :quantity, :quantity_type, :cook_id, :price, :stock, :image
end
