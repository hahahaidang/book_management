class Book < ActiveRecord::Base
  has_many :request
  has_many :user, through: :request

  validates :book_name, length: {maximum: 255}, presence: true
  validates :book_quantity, numericality: {less_than: 100, greater_than: 0, only_integer: true}, presence:true;



end
