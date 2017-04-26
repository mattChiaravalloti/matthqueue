class CreateAccountsCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts_courses do |t|
      t.reference :account
      t.reference :course

      t.timestamps
    end
  end
end
