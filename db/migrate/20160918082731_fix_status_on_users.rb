class FixStatusOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :staus, :status
  end
end
