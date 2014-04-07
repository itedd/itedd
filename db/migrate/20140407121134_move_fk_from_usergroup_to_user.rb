class MoveFkFromUsergroupToUser < ActiveRecord::Migration
  def up
    remove_column :user_groups, :user_id
    add_column :users, :user_group_id, :integer

    add_index :users, ["user_group_id"], name: "index_user_group_id_on_users", using: :btree
  end
end
