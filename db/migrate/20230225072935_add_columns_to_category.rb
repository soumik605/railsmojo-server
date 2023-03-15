class AddColumnsToCategory < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :description, :text
    add_column :categories, :parent_category_id, :integer
  end
end
