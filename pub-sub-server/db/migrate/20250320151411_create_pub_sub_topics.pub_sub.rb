# This migration comes from pub_sub (originally 20250319172802)
class CreatePubSubTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :pub_sub_topics do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
