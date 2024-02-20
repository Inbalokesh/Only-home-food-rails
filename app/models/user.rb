require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :id, :name, :mobile_number, :password, :is_admin, :email, :image
  has_many :orders
  has_many :products, through: :orders

    
  validates :name, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :mobile_number, presence: true, format: { with: /\A\d{10}\z/, message: "only allows numbers and number should contain 10 digit" }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'Invalid email format' }
  validates :is_admin, inclusion: { in: [true, false] }
  validates :password, presence: true, length: { minimum: 8 }
  # validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "should include at least one letter and one digit" }
  
  include BCrypt

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def authenticate(password)
    if BCrypt::Password.new(password_digest) == password
      return self
    else
      return false
    end
  end

end
