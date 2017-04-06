require 'digest/sha1'
class User < ActiveRecord::Base

  has_many :request
  has_many :book, :through => :request

  validates :user_name, length: { in: 5..16 }, presence:true
  validates :user_pwd, length: { maximum:128 }, presence:true




end
