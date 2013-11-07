class AddTwitterAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter_account, :string
  end
end
