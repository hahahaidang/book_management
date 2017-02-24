class Book < ActiveRecord::Base
  has_many request, through: :user
end
