class CreatePetLists < ActiveRecord::Migration
  def change
    create_table :pet_lists do |t|

      t.timestamps
    end
  end
end
