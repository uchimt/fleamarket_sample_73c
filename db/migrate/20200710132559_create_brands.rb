class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.references :product, foreign_key: true
      t.string :brand_name
      t.timestamps
    end
    
  end
end
