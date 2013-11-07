class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :text, :length => 200, :nullable => false
      t.string :link, :length => 200, :nullable => false
      t.date :happens_at, :nullable => false
      t.integer :user_id, :nullable => false

      t.timestamps
    end
  end
end
