class CreateOriginals < ActiveRecord::Migration
  def change
    create_table :originals do |t|
      t.integer :movie_id
      t.integer :meta_id

      t.timestamps null: false
    end
  end
end
