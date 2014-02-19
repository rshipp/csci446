class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :pet_id

      t.timestamps
    end
  end
end
