# This migration comes from pub_sub (originally 20250319201108)
class CreatePubSubDeliveries < ActiveRecord::Migration[8.0]
  def change
    create_table :pub_sub_deliveries do |t|
      t.references :pub_sub_message, null: false, foreign_key: true
      t.references :pub_sub_client, null: false, foreign_key: true
      t.boolean :success

      t.timestamps
    end
  end
end
