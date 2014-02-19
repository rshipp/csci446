class AddStatusToPet < ActiveRecord::Migration
  def change
    add_column :pets, :status, :string
  end
end
