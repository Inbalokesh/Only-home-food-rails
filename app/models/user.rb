class User < ActiveRecord::Base
  attr_accessible :id, :name, :mobile_number, :password
  # attr_accessible :title, :body
  validates :name, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :mobile_number, presence: true, format: { with: /\A\d{10}\z/, message: "only allows numbers and number should contain 10 digit" }
  validates :password, presence: true, length: { minimum: 8 }
  validate :password_complexity

  private

  def password_complexity
    unless password =~ /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$/
      errors.add :password, "must contain at least one lowercase letter, one uppercase letter, one number, and one special character"
    end
  end
end
