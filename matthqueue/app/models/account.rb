require 'bcrypt'

class Account < ApplicationRecord
  include BCrypt

  validates :email, :name, :password_hash, presence: true
  validates_uniqueness_of :email
  validates_length_of :name, minimum: 2
  validate :email_regex

  belongs_to :institution

  def email_regex
    err = 'email not permitted by institution'
    errors.add(:email, err) unless !institution.nil? && email.end_with?(institution.email_regex)
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
