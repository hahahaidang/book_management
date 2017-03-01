class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.text :book_name
      t.text :book_link
      t.text :book_description
      t.float :book_price
      t.integer :book_quantity

      t.timestamps null: false
    end
  end
end
