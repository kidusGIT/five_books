class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.integer :book_id
      t.boolean :is_removed, default: false

      t.timestamps
    end
  end
end
