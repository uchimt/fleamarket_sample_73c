class CreateSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :sizes do |t|
      t.string :size, null: false
      t.timestamps
    end
    add_reference :products, :size, foreign_key: true
  end
end
