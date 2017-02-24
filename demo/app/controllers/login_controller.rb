require 'digest/sha1'
class LoginController < ApplicationController


  def login_page
    if session[:user] != nil
      redirect_to '/welcome/index'
    end
  end


  def sign_in
    usr = Digest::SHA1.hexdigest(params['tf_username'])
    pass = Digest::SHA1.hexdigest(params['tf_password'])
    @action = User.new
    if @action.func_login(usr,pass) == 1
      session[:user] = usr
      redirect_to '/welcome/index'
    else
      redirect_to '/login/login_page'
    end
  end


  def login_fail
  end

  def logout_page
    session[:user] = nil
  end
end
