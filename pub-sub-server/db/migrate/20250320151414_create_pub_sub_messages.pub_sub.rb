# This migration comes from pub_sub (originally 20250319200140)
class CreatePubSubMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :pub_sub_messages do |t|
      t.references :pub_sub_topic, null: false, foreign_key: true
      t.references :pub_sub_client, null: false, foreign_key: true
      t.json :content

      t.timestamps
    end
  end
end
