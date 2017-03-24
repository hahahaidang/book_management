class AddLinkimgAndRequestLikeToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :image_link, :text
    add_column :requests, :quantity_of_like, :integer
  end
end
