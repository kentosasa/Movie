class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.text :description
      t.text :story
      t.integer :status

      t.timestamps null: false
    end
  end
end
