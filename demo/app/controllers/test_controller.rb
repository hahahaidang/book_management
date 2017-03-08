class TestController < ApplicationController
  def test_page

  end

  def list_book
    sql = "SELECT book_name FROM books"
    @result = ActiveRecord::Base.connection.exec_query(sql)
    return render json: @result
  end
end
