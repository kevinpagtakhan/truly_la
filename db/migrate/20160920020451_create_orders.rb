class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :shipping_street
      t.string :shipping_street_2
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip_code
      t.string :payment_status
      t.string :shipment_status

      t.timestamps null: false
    end
  end
end
