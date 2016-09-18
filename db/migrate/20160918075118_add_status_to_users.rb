class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :staus, :boolean, :default => true
  end
end
