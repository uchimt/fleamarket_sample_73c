class CreateCategorySizes < ActiveRecord::Migration[5.2]
  def change
    create_table :category_sizes do |t|
      t.integer :category_id
      t.integer :size_id
      t.timestamps
    end
  end
end
