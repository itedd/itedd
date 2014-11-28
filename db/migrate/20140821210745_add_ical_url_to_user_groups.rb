class AddIcalUrlToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :ical_url, :string
  end
end
