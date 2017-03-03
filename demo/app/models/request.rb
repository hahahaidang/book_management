class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :status, presence: true, length: {maximum: 1}
  validates :quantity, presence:true, length: {maximum: 3}

end
