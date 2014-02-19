class CreatePetItems < ActiveRecord::Migration
  def change
    create_table :pet_items do |t|
      t.references :pet, index: true
      t.belongs_to :pet_list, index: true

      t.timestamps
    end
  end
end
