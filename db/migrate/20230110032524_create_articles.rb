class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.belongs_to :category, null: false, foreign_key: true
      t.belongs_to :rails_version, null: false, foreign_key: true
      t.string :key
      t.string :github_link
      t.string :author_name
      t.datetime :piblished_at

      t.timestamps
    end
  end
end
