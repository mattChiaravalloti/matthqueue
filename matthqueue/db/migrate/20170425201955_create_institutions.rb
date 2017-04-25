class CreateInstitutions < ActiveRecord::Migration[5.0]
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :password_hash
      t.string :secret
      t.string :email_regex

      t.timestamps
    end
  end
end
