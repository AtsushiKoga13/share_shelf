class AddTagIdToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :tag_id, :integer
  end
end
