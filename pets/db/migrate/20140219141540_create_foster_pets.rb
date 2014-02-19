class CreateFosterPets < ActiveRecord::Migration
  def change
    create_table :foster_pets do |t|
      t.references :pet, index: true

      t.timestamps
    end
  end
end
