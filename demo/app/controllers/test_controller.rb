class TestController < ApplicationController
  def test_page
    inputStatus = params[:status]
    userName = session[:user]
    userID = User.find_by_user_name(userName).id
    @request = Request.where('status = ? AND user_id = ? ',inputStatus, userID )
  end

  def list_book
    sql = "SELECT book_name FROM books"
    @result = ActiveRecord::Base.connection.exec_query(sql)
    return render json: @result
  end
end
