class AddDefaultValuesToProducts < ActiveRecord::Migration
  def change
    change_column :products, :inventory, :integer, :default => 0
    change_column :products, :sale_price, :float, :default => nil
    change_column :products, :height, :float, :default => nil
    change_column :products, :width, :float, :default => nil
    change_column :products, :depth, :float, :default => nil
    change_column :products, :weight, :float, :default => nil
  end
end
