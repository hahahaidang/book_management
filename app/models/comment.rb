class Comment < ActiveRecord::Base
  validates :request_id, numericality: { only_integer: true }, presence:true
  validates :content, length: { maximum: 255 }
end
