class OhQueue < ApplicationRecord
  belongs_to :course
  has_many :questions

  def avg_wait_time
    sum = 0
    total = 0
    self.questions.each do |q|
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
end
