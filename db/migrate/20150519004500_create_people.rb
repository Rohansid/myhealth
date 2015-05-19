class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.text :username
      t.text :email

      t.timestamps null: false
    end
  end
end
