# This migration comes from pub_sub (originally 20250319202451)
class AddKeyToPubSubKeys < ActiveRecord::Migration[8.0]
  def change
    add_column :pub_sub_keys, :key, :text
  end
end
