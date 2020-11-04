class ChangeDataTitleToBooks < ActiveRecord::Migration[6.0]
  def change
    change_column :books, :title, :string, null: false
  end
end
