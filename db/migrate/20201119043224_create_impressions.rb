class CreateImpressions < ActiveRecord::Migration[6.0]
  def change
    create_table :impressions do |t|
      t.text :content
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
    add_index :impressions, [:book_id, :created_at]
  end
end
