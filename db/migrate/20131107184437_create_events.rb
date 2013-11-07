class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :text
      t.string :link
      t.date :happens_at
      t.integer :user_id

      t.timestamps
    end
  end
end
