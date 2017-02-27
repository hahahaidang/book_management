require 'digest/sha1'
class User < ActiveRecord::Base

  has_many :request
  has_many :book, :through => :request

  def createUser(username,password)
    @newUsr = User.new
    @newUsr.user_name= username
    @newUsr.user_pwd= Digest::SHA1.hexdigest(password)
    @newUsr.save()
  end




  def func_login(usr,pass)
    if User.find_by_user_name(usr) &&  User.find_by_user_pwd(pass)
      return 1
    end
  end





end
