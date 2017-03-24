class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :status, presence: true, length: {maximum: 1}, numericality: {only_integer: true}
  validates :quantity, presence:true, length: {maximum: 3}, numericality: {only_integer: true, greater_than: 0}
  validates :book_link, length: {maximum: 400}, presence:true
  validates :image_link, length: {maximum: 400}
  validates :quantity_of_like, numericality: {greater_than: -1, less_than: 3, only_integer: true}
  validates :admin_comment, length: {maximum: 255}
  validates :book_price, presence: true, numericality: {greater_than: -1, only_float: true}
end
