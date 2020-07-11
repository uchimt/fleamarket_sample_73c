class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :condition, null: false, dafault: 0
      t.integer :prefecture_id, null: false
      t.integer :postage, null: false, dafault: 0
      t.integer :shipping_day_id, null: false
      t.integer :price, null: false
      # t.references :user, foreign_key :true, null: false
      # t.references :comment, foreign_key :true
      # t.references :brand, foreign_key :true
      # t.references :like, foreign_key :true
      # t.references :category, foreign_key :true, null: false
      t.timestamps
    end
  end
end
