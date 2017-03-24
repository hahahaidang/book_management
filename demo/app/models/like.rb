class Like < ActiveRecord::Base
  validates :user_id, numericality: {only_integer: true}, presence:true
  validates :request_id, numericality: {only_integer: true}, presence:true
end
