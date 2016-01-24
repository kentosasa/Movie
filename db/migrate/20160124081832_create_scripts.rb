class CreateScripts < ActiveRecord::Migration
  def change
    create_table :scripts do |t|
      t.integer :movie_id
      t.integer :meta_id

      t.timestamps null: false
    end
  end
end
