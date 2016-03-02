class AddMeetupUrlToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :meetup_url, :string
  end
end
