class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, default: ''
      t.string :author, null: false
      t.decimal :price, default: 0.0
      t.string :genre
      t.date :year, null: false

      t.timestamps
    end
  end
end
