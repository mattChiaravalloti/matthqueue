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

  has_many :oh_queues

  def avg_wait_time
    sum = 0
    total = 0
    self.oh_queues.each do |q|
      wait_time = q.avg_wait_time
      if wait_time > 0
        sum = sum + wait_time
        total = total + 1
      end
    end

    if total > 0
      sum / total
    else
      0
    end
  end

  def professors
    self.instructors.where(:professor=>true)
  end

  def tas
    self.instructors.where(:professor=>false)
  end
end
