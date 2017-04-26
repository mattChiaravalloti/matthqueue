class AddOhTimeSlotToOhQueues < ActiveRecord::Migration[5.0]
  def change
    add_reference :oh_queues, :oh_time_slot, foreign_key: true
  end
end
