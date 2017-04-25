class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.boolean :professor
      t.references :institution, foreign_key: true

      t.timestamps
    end
  end
end
