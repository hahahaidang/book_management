class AddAdminCommentToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :admin_comment, :string
  end
end
