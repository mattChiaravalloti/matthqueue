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

  has_many :oh_time_slots
  has_many :oh_queues, :through => :oh_time_slots
  has_many :questions, :through => :oh_queues

  def avg_wait_time
    sum = 0
    total = 0
    self.oh_queues.each do |q|
      wait_time = q.avg_wait_time
      if wait_time > 0
        sum += wait_time
        total += 1
      end
    end

    if total > 0
      sum / total
    else
      0
    end
  end

  def avg_wait_time_for(student)
    sum = 0
    total = 0
    self.oh_queues.each do |q|
      wait_time = q.avg_wait_time_for(student)
      if wait_time > 0
        sum += wait_time
        total += 1
      end
    end

    if total > 0
      ((sum / total) / 60).round(2)
    else
      0
    end
  end

  def lifetime_wait_time_for(student)
    (self.oh_queues
      .reduce(0) { |sum, q| sum + q.total_wait_time_for(student) } / 60)
        .round(2)
  end

  def questions_for(student)
    self.questions.where(:student=>student)
  end

  def professors
    self.instructors.where(:professor=>true)
  end

  def tas
    self.instructors.where(:professor=>false)
  end
end
