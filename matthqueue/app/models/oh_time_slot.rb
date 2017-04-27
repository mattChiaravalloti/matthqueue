class OhTimeSlot < ApplicationRecord
  belongs_to :course
  has_many :oh_queues
  has_many :questions, :through => :oh_queues

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

  def total_wait_time
    self.questions.reduce(0) { |sum, q| sum + q.wait_time }
  end

  def queue_active?
    self.oh_queues.where(:active=>true).length > 0
  end

  def active_queue
    self.oh_queues.where(:active=>true).first
  end

  def total_num_questions
    self.oh_queues.reduce(0) { |sum, q| sum + q.questions.length }
  end

  def num_unique_students
    self.questions.map { |q| q.student }.uniq.length
  end

  def num_unique_instructors
    self.questions.map { |q| q.resolver }.uniq.length
  end
end
