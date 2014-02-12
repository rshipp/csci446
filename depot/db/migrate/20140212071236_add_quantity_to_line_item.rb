class AddQuantityToLineItem < ActiveRecord::Migration
    def self.up
        add_column :line_items, :quantity, :integer, :default => 1
    end
    def self.down
        ITERATION E1: C REATING A remove_column :line_items, :quantity
    end
end

