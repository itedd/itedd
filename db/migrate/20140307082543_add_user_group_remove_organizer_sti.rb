class AddUserGroupRemoveOrganizerSti < ActiveRecord::Migration
  def change
    rename_column :events, :user_id, :user_group_id

    add_index "events", ["user_group_id"], name: "index_events_on_user_group_id", using: :btree

    create_table "user_groups", force: true do |t|
      t.string   "name"
      t.string   "twitter_account"
      t.string   "color",                  limit: 7
      t.string   "logo",                   limit: 200
      t.string   "website",                limit: 200
      t.string   "description",            limit: 400
      t.string   "facebook_page",          limit: 200
      t.string   "googleplus_page",        limit: 200
      t.integer  "user_id"
    end

    add_index "user_groups", ["user_id"], name: "index_user_groups_on_user_id", using: :btree

    remove_column :users, :username
    remove_column :users, :twitter_account
    remove_column :users, :type
    remove_column :users, :color
    remove_column :users, :logo
    remove_column :users, :website
    remove_column :users, :description
    remove_column :users, :facebook_page
    remove_column :users, :googleplus_page
  end
end
