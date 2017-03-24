require 'digest/sha1'
include LoginHelper
class LoginController < ApplicationController



  def login_page
    unless session[:user].nil?
      redirect_to index_page_path
    end
  end


  def sign_in
    usr = params['tf_username']
    pass = Digest::SHA1.hexdigest(params['tf_password'])
    #validates
    if usr.blank?
      flash[:notice] = 'Username must not be blank!'
      redirect_to :back
    end
    if (usr.length < 5) || (usr.length > 16)
      flash[:notice] = 'Username must greater than 5 and less than 16!'
      redirect_to :back
    end
    if params['tf_password'].blank?
      flash[:notice] = 'Password must not be blank!'
      redirect_to :back
    end
    if func_login(usr,pass) == 1
      session[:user] = usr
      if (check_permission()==1)
        #admin will be redirected to approve page
        redirect_to approve_page_path
      else
        redirect_to index_page_path
      end
    else
      #invalid username or password
      redirect_to :back
      flash[:notice] = 'Incorrect username or password!'
    end


    # if usr.blank?
    #   flash[:notice] = 'Username must not be blank!'
    #   redirect_to :back
    # else
    #   if (usr.length < 5) || (usr.length > 16)
    #     flash[:notice] = 'Username must greater than 5 and less than 16!'
    #     redirect_to :back
    #   else
    #     if params['tf_password'].blank?
    #       flash[:notice] = 'Password must not be blank!'
    #       redirect_to :back
    #     else
    #       #pass condition then login
    #       if func_login(usr,pass) == 1
    #         session[:user] = usr
    #         if (check_permission()==1)
    #           #admin will be redirected to approve page
    #           redirect_to approve_page_path
    #         else
    #           redirect_to index_page_path
    #         end
    #       else
    #         #invalid username or password
    #         redirect_to :back
    #         flash[:notice] = 'Incorrect username or password!'
    #       end
    #     end
    #   end
    # end

  end


  def logout_page
    #destroy session
    session[:user] = nil
  end
end
