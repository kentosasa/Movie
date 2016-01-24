class CreateMeta < ActiveRecord::Migration
  def change
    create_table :meta do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
