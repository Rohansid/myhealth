class CreateCheckAllergies < ActiveRecord::Migration
  def change
    create_table :check_allergies do |t|
      t.text :allergy
      t.text :allergen
      t.text :allergyreaction

      t.timestamps null: false
    end
  end
end
