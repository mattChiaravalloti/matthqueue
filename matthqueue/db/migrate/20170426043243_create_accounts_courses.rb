class CreateAccountsCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts_courses do |t|
      t.references :account
      t.references :course
      t.boolean :student

      t.timestamps
    end
  end
end
