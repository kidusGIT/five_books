class AddIsSoldToBook < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :is_sold, :boolean, default: false
  end
end
