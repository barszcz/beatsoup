class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :track_id, null: false
      t.integer :user_id, null: false
      t.integer :parent_id
      t.text :body, null: false

      t.timestamps
    end
    add_index :comments, :track_id
    add_index :comments, :parent_id
  end
end
