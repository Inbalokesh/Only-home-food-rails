class Order < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :id, :address, :order_status, :quantity_ordered, :total_price, :delivery_time, :product_id, :user_id

  belongs_to :user
  belongs_to :product

  validates :address, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?(?:, [a-zA-Z]+)?\z/, message: "only allows alphabets with a single space in between and a comma separating city and region" }
  validates :order_status, inclusion: { in: ["Delivered", "Not-delivered", "Cancelled"], message: "%{value} is not a valid order status" }
  validates :product_id, numericality: { only_integer: true, message: "must be an integer" }
  validates :user_id, numericality: { only_integer: true, message: "must be an integer" }
  validates :total_price, numericality: { only_integer: true, message: "must be an integer" }
  validates :quantity_ordered, numericality: { only_integer: true, message: "must be an integer" }
  validates :quantity_ordered, inclusion: { in: 1..10, message: "must be between 10 and 1500" }

  validates :delivery_time, presence: true
end
