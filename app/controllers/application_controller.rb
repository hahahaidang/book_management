class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def check_permission
     @admin_role = Rails.application.secrets.admin
     user = session[:user]
     unless user.nil?
       #if session user is not nil
       #admin: role = 1, member role = 0
       @admin_role.include?(user) ? @role = 1 : @role = 0
     end
  end


end


