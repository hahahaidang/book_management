class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :status, presence: true, length: {maximum: 1}, numericality: {only_integer: true}
  validates :quantity, presence:true, length: {maximum: 3}, numericality: {only_integer: true}
  validates :book_link, length: {maximum: 255}, presence:true
  validates :book_price, presence: true, numericality: {less_than: 1000, greater_than: 0, }
end
