class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :status, presence: true, length: {maximum: 1}, numericality: {only_integer: true}
  validates :quantity, presence:true, length: {maximum: 3}, numericality: {only_integer: true, greater_than: 0, less_than: 101}
  validates :book_link, length: {maximum: 255}, presence:true
  validates :book_price, presence: true, numericality: {less_than: 1001, greater_than: -1, only_float: true}
end
