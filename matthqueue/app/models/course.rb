class Course < ApplicationRecord
  belongs_to :institution

  validates :name, :semester, presence: true
  validates_uniqueness_of :name, scope: [:institution, :semester]

  has_many :accounts_courses, dependent: :destroy

  # enable get all students via course.students (this is a list of Accounts)
  has_many(:enrolled,
    -> {where(student:true)},
    class_name: 'AccountsCourse'
  )
  has_many :students, :through => :enrolled, :source => :account

  # enable get all instructors via course.instructors
  has_many(:lecturers,
    -> {where(student:false)},
    class_name: 'AccountsCourse'
  )
  has_many :instructors, :through => :lecturers, :source => :account
end
