class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def check_permission
     @admin_role = Rails.application.secrets.admin
     user = session[:user]
     if !(user.nil?)
       if @admin_role.include?(user)
         #isAdmin
         @role = 1
       else
         #isMember
         @role = 0
       end
     end
  end


end


