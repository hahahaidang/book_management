class Book < ActiveRecord::Base
  has_many :request
  has_many :user, through: :request

  validates :book_name, length: { maximum: 255 }, presence: true
  validates :book_quantity, numericality: { only_integer: true }, presence:true

  def self.book_like name
    self.where('book_name like ?', "#{name}%")
  end

end
