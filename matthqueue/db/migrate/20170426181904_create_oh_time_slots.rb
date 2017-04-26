class CreateOhTimeSlots < ActiveRecord::Migration[5.0]
  def change
    create_table :oh_time_slots do |t|
      t.string :frequency
      t.datetime :start_time
      t.datetime :end_time
      t.references :course, foreign_key: true
      t.integer :avg_wait_time

      t.timestamps
    end
  end
end
