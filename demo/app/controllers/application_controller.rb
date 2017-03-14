class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def check_permission
     @admin_role = Rails.application.secrets.admin
     if @admin_role.include?(session[:user])
       @role = 1
     else
       @role = 0
     end
  end


end


