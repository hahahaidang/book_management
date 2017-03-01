class Book < ActiveRecord::Base
  has_many :request
  has_many :user, through: :request




end
