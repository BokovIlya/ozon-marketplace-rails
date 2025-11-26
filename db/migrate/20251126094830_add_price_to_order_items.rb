class AddPriceToOrderItems < ActiveRecord::Migration[8.1]
  def change
    add_column :order_items, :price, :decimal
  end
end
