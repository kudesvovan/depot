class RemovePaymentTypeFromOrder < ActiveRecord::Migration
  def change
  	remove_column :orders, :payment_type_id
  end
end
