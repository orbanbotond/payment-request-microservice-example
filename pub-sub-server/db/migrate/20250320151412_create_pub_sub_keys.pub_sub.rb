# This migration comes from pub_sub (originally 20250319185848)
class CreatePubSubKeys < ActiveRecord::Migration[8.0]
  def change
    create_table :pub_sub_keys do |t|
      t.references :pub_sub_client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
