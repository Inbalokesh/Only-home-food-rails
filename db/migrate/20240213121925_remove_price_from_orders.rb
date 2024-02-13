class RemovePriceFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :total_price
  end

end
