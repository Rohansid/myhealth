class CreateAllergies < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
      t.text :allergy_type
      t.text :allergen

      t.timestamps null: false
    end
  end
end
