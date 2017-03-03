class Book < ActiveRecord::Base
  has_many :request
  has_many :user, through: :request

  validates :book_name, length: {maximum: 255}, presence: true
  validates :book_link, length: {maximum: 255}
  validates :book_description, length: {maximum: 255}
  validates :book_price, presence: true, numericality: {less_than: 1000, greater_than: 0}
  validates :book_quantity, presence: true, numericality: {less_than: 100, greater_than: 0}



end
