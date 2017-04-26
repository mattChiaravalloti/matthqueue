class RemoveCourseFromOhQueues < ActiveRecord::Migration[5.0]
  def change
    remove_reference :oh_queues, :course, foreign_key: true
  end
end
