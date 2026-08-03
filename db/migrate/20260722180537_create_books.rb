class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string  :title, null: false
      t.string  :author, null: false
      t.string  :isbn, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.text    :description
      t.integer :stock, null: false, default: 0
      t.string  :cover_url
      t.boolean :published, null: false, default: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :books, :isbn, unique: true
  end
end