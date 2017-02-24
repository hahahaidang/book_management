class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user, index: true
      t.references :book, index: true
      t.integer :status
      t.date :date_request
      t.date :date_approve

      t.timestamps null: false
    end
    add_foreign_key :requests, :users
    add_foreign_key :requests, :books
  end
end
