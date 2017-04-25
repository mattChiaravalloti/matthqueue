require 'bcrypt'

class Institution < ApplicationRecord
  include BCrypt

  validates :name, :email_regex, presence: true
  validates_uniqueness_of :name
  validates_length_of :name, minimum: 2

  has_many :accounts, dependent: :destroy

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
