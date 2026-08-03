class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_amount, precision: 10, scale: 2, null: false, default: 0.00
      t.integer :status, null: false, default: 0
      t.text :shipping_address, null: false

      t.timestamps
    end

    add_index :orders, :status
  end
end