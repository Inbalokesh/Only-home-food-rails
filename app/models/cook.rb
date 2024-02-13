class Cook < ActiveRecord::Base
  attr_accessible :id, :first_name, :last_name, :email

  has_many :products

  # attr_accessible :title, :body
  validates :first_name, format: { with: /\A[a-zA-Z]+(?:\s[a-zA-Z]+)?\z/, message: "only allows alphabets with a single space in between" }
  validates :last_name, format: { with: /\A[a-zA-Z]+(?:\s[a-zA-Z]+)?\z/, message: "only allows alphabets with a single space in between" }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'Invalid email format' }
end
