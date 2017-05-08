class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :user_pwd
      t.text :user_name

      t.timestamps null: false
    end
  end
end
