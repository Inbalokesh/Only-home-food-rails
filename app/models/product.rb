class Product < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :id, :name, :quantity, :quantity_type, :price, :stock, :cook_id, :food_type, :image

  belongs_to :cook

  has_many :orders
  has_many :users, through: :orders

  validates :name, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :quantity_type, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :food_type, inclusion: { in: ['Veg', 'Non-Veg'], message: "%{value} is not a valid food type" }
  validates :price, numericality: { only_integer: true, message: "must be an integer" }
  validates :price, inclusion: { in: 10..1500, message: "must be between 10 and 1500" }
  validates :quantity, numericality: { only_integer: true, message: "must be an integer" }
  validates :quantity, inclusion: { in: 1..1000, message: "must be between 1 and 1000" }
  validates :stock, numericality: { only_integer: true, message: "must be an integer" }
  validates :stock, inclusion: { in: 0..100, message: "must be between 1 and 100" }
  validates :cook_id, numericality: { only_integer: true, message: "must be an integer" }

end
