class CreateYoutubes < ActiveRecord::Migration
  def change
    create_table :youtubes do |t|
      t.integer :movie_id
      t.string :youtube_id
      t.string :title

      t.timestamps null: false
    end
  end
end
