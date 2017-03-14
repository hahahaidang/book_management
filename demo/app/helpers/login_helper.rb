module LoginHelper

  def createUser(username, password)
    self.user_name= username
    self.user_pwd= Digest::SHA1.hexdigest(password)
    self.save
  end


  def func_login(usr, pass)
    if User.find_by_user_name(usr) && User.find_by_user_pwd(pass)
      return 1
    end
  end
end
