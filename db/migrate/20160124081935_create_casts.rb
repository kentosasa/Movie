class CreateCasts < ActiveRecord::Migration
  def change
    create_table :casts do |t|
      t.integer :movie_id
      t.integer :meta_id

      t.timestamps null: false
    end
  end
end
