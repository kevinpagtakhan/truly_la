class AddEmailToStoreManagers < ActiveRecord::Migration
  def change
    add_column :store_managers, :email, :string
  end
end
