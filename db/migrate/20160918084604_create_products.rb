class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :user, index: true, foreign_key: true
      t.string :sku
      t.string :name
      t.string :description
      t.integer :inventory
      t.float :wholesale_price
      t.float :regular_price
      t.float :sale_price
      t.float :height
      t.float :width
      t.float :depth
      t.float :weight

      t.timestamps null: false
    end
  end
end
