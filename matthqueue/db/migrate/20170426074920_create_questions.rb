class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.references :queue, foreign_key: true
      t.integer :position
      t.references :student, foreign_key: true
      t.references :resolver, foreign_key: true
      t.string :status
      t.timestamp :resolve_time

      t.timestamps
    end
  end
end
