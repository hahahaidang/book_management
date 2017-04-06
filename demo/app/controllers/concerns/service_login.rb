module ServiceLogin

  extend ActiveSupport::Concern

  def createUser(username, password)
    @action = User.new
    @action.user_name= username
    @action.user_pwd= Digest::SHA1.hexdigest(password)
    @action.save!
  end

  def func_login(usr, pass)
    if User.find_by_user_name(usr) && User.find_by_user_pwd(pass)
      return 1
    end
  end
end