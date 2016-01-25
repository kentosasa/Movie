class CreateMeta < ActiveRecord::Migration
  def change
    create_table :meta do |t|
      t.string :name
      t.text :description
      t.integer :category, default: 0, null: false

      t.timestamps null: false
    end
  end
end
