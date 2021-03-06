class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title,             null: false
      t.text :description,         null: false
      t.integer :condition,        null: false
      t.integer :prefecture_id,    null: false
      t.integer :postage,          null: false
      t.integer :shipping_day_id,  null: false
      t.integer :price,            null: false
      t.integer :status,           null: false, default: 0
      t.references :user,          null: false, foreign_key: true
      # t.references :comment, foreign_key :true
      # t.references :like, foreign_key :true
      # t.references :category, foreign_key :true, null: false
      t.timestamps
    end
  end
end
