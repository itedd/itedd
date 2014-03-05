class AddPropertiesToUser < ActiveRecord::Migration
  def change
    add_column :users, :color, :string, :limit=>7
    add_column :users, :logo, :string, :limit=>200
    add_column :users, :website, :string, :limit=>200
    add_column :users, :description, :string, :limit=>400
    add_column :users, :facebook_page, :string, :limit=>200
    add_column :users, :googleplus_page, :string, :limit=>200
  end
end
