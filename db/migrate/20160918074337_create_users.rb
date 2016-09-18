class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :shipping_street
      t.string :shipping_street_2
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip_code
      t.string :role
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
