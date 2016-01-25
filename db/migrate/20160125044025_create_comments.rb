class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :movie_id
      t.string :user_name
      t.text :text

      t.timestamps null: false
    end
  end
end
