class AddImageToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :image, :string
    add_column :posts, :name, :string
  end
end
