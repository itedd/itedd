class AddTwitterIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :twitter_id, :string
    add_index :events, :twitter_id
  end
end
