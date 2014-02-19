class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.string :breed
      t.integer :age
      t.boolean :shots
      t.text :notes
      t.string :image_url

      t.timestamps
    end
  end
end
