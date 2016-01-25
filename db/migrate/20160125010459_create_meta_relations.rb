class CreateMetaRelations < ActiveRecord::Migration
  def change
    create_table :meta_relations do |t|
      t.integer :movie_id
      t.integer :meta_id

      t.timestamps null: false
    end
  end
end
