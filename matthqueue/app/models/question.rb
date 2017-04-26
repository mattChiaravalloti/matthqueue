class Question < ApplicationRecord
  belongs_to :oh_queue, class_name: 'OhQueue'
  belongs_to :student, class_name: 'Account'
  belongs_to :resolver, class_name: 'Account'

  def wait_time
    -1 if self.status != 'resolved'

    self.resolve_time - self.created_at
  end
end
