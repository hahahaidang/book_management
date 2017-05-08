class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.text :book_name
      t.integer :book_quantity
      t.timestamps null: false

    end
  end
end
