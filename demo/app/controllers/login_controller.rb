require 'digest/sha1'
include ServiceLogin
class LoginController < ApplicationController
  before_action :before_sign_in, only:[:sign_in]


  def login_page
    unless session[:user].nil?
      redirect_to index_page_path
    end
  end


  def sign_in
    usr = params['tf_username']
    pass = Digest::SHA1.hexdigest(params['tf_password'])

    if func_login(usr,pass) == 1
      session[:user] = usr
      #admin redirect to approve_page, anyone else redirect to index_page
      check_permission() == 1 ? (redirect_to approve_page_path) : (redirect_to index_page_path)
    else
      #invalid username or password
      redirect_to :back
      flash[:notice] = 'Incorrect username or password!'
    end
  end

  def before_sign_in
    usr = params['tf_username']
    #validation
    if usr.blank?
      flash[:notice] = 'Username must not be blank!'
      return redirect_to :back
    end
    if (usr.length < 4) || (usr.length > 16)
      flash[:notice] = 'Username must greater than 3 and less than 16!'
      return redirect_to :back
    end
    if params['tf_password'].blank?
      flash[:notice] = 'Password must not be blank!'
      return redirect_to :back
    end

  end


  def logout_page
    #destroy session
    session[:user] = nil
  end
end
