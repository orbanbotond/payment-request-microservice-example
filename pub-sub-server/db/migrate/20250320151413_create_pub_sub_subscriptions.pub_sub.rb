# This migration comes from pub_sub (originally 20250319190730)
class CreatePubSubSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :pub_sub_subscriptions do |t|
      t.string :callback_url, null: false
      t.references :pub_sub_client, null: false, foreign_key: true
      t.references :pub_sub_topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
