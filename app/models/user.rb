class User < ApplicationRecord
  has_many :projects
  has_many :tasks, through: :projects
  has_secure_password

  before_validation :downcase_email
  validates_presence_of :email, :password, :first_name, :last_name
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :first_name, format: { with: /\A[a-z]+\z/i }
  validates :last_name, format: { with: /\A[a-z]+\z/i }

  private
  # Downcase email characters before validating and persisting
  def downcase_email
    self.email.downcase! if self.email
  end

end
