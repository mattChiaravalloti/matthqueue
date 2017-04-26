class OhTimeSlot < ApplicationRecord
  belongs_to :course
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
end
