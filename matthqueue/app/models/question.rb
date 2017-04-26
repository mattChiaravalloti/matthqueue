class Question < ApplicationRecord
  belongs_to :oh_queue, class_name: 'OhQueue'
  belongs_to :student, class_name: 'Account'
  belongs_to :resolver, class_name: 'Account', optional: true

  def wait_time
    if self.status != 'resolved'
      -1
    else
      self.resolve_time - self.created_at
    end
  end
end
