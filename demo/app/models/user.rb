require 'digest/sha1'
class User < ActiveRecord::Base

  has_many :request
  has_many :book, :through => :request






end
