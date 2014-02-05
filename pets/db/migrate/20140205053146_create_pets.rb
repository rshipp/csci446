class CreatePets < ActiveRecord::Migration
  def self.up
    create_table :pets do |t|
      t.string :name
      t.string :breed
      t.string :image_url
      t.integer :age
      t.boolean :shots
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :pets
  end
end
