class Cook < ActiveRecord::Base
  attr_accessible :id, :first_name, :last_name

  has_many :products

  # attr_accessible :title, :body
  validates :first_name, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :last_name, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
end