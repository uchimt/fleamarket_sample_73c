class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :condition
      t.integer :postage
      t.integer :price
      t.references :user
      t.references :comment
      t.references :brand
      t.references :like
      t.references :category
      t.integer :prefecture_id
      t.references :shipping_day
      t.timestamps
    end
  end
end
