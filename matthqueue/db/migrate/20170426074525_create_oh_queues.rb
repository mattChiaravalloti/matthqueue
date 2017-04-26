class CreateOhQueues < ActiveRecord::Migration[5.0]
  def change
    create_table :oh_queues do |t|
      t.boolean :active
      t.integer :last_position
      t.references :course, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :num_tas

      t.timestamps
    end
  end
end
