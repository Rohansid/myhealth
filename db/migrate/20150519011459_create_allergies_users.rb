class CreateAllergiesUsers < ActiveRecord::Migration
  def change
    create_table :allergies_users do |t|
      t.integer :allergy_id
      t.integer :user_id
    end
  end
end
