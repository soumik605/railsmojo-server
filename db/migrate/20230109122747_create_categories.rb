class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.belongs_to :rails_version, null: false, foreign_key: true
      t.string :name
      t.string :slug
      t.integer :position
      t.boolean :is_active

      t.timestamps
    end
  end
end
