require 'bcrypt'

class Account < ApplicationRecord
  include BCrypt

  validates :email, :name, :password_hash, presence: true
  validates_uniqueness_of :email
  validates_length_of :name, minimum: 2
  validate :email_regex

  belongs_to :institution
  has_many :accounts_courses, dependent: :destroy

  # enable get all enrolled courses via account.enrolled_courses (this is a list
  # of Courses)
  has_many(:enrollments,
    -> {where(student: true)},
    class_name: 'AccountsCourse'
  )
  has_many :enrolled_courses, :through => :enrollments, :source => :course

  # enable get all instructed courses via account.instructed_courses
  has_many(:lectures,
    -> {where(student: false)},
    class_name: 'AccountsCourse'
  )
  has_many :instructed_courses, :through => :lectures, :source => :course

  # questions
  has_many :questions, :through => :enrolled_courses
  has_many :answers, :through => :instructed_courses, :source => :question

  def email_regex
    err = 'email not permitted by institution'
    valid = !institution.nil? && email.end_with?(institution.email_regex)
    errors.add(:email, err) unless valid
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
