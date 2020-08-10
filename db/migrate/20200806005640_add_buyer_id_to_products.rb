class AddBuyerIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :buyer_id, :integer
  end
end
