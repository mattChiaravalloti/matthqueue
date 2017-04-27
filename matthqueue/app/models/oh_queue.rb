class OhQueue < ApplicationRecord
  belongs_to :oh_time_slot
  has_many :questions
  has_many :students, through: :questions
  has_many :resolvers, through: :questions

  def avg_wait_time
    sum = 0
    total = 0
    self.questions.each do |q|
      wait_time = q.wait_time
      if wait_time != -1
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

  def avg_wait_time_for(student)
    sum = 0
    total = 0
    self.questions.select { |q| q.student == student }.each do |q|
      wait_time = q.wait_time
      p wait_time
      if wait_time != -1
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

  def total_wait_time_for(student)
    self.questions
      .select { |q| q.student == student }
      .reduce(0) { |sum, q| sum + q.wait_time }
  end

  def num_unique_students
    self.questions.map { |q| q.student }.uniq.length
  end

  def num_unique_instructors
    self.questions.map { |q| q.resolver }.uniq.length
  end

  def unresolved_questions
    self.questions.order(:position).select { |q| q.status != 'resolved' }
  end

  def resolved_questions
    self.questions.order(:position).select { |q| q.status == 'resolved' }
  end

  def unresolved_question_for(student)
    self.questions.select do |q|
      q.student == student && q.status == 'unresolved'
    end.first
  end

  def next_position
    pos = self.last_position
    self.last_position = pos + 1
    save!
    pos
  end
end
