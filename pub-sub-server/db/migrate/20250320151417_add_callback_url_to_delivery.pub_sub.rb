# This migration comes from pub_sub (originally 20250320090548)
class AddCallbackUrlToDelivery < ActiveRecord::Migration[8.0]
  def change
    add_column :pub_sub_deliveries, :callback_url, :string
  end
end
