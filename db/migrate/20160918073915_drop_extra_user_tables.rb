class DropExtraUserTables < ActiveRecord::Migration
  def change
    drop_table :customers
    drop_table :store_managers
    drop_table :suppliers
  end
end
