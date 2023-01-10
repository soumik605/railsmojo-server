class CreateRailsVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :rails_versions do |t|
      t.string :name
      t.string :slug
      t.boolean :is_default
      t.boolean :is_active

      t.timestamps
    end
  end
end
