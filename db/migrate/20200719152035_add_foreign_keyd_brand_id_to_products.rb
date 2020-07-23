class AddForeignKeydBrandIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :brand, foreign_key: true
    add_reference :products, :category, foeign_key: true, null: false
  end
end
