class CreateStoreManagers < ActiveRecord::Migration
  def change
    create_table :store_managers do |t|
      t.string :username
      t.string :password_digest
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
