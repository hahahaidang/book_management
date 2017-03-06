class WelcomeController < ApplicationController
  def index
    @page_title = 'Index page'
    @collection = Request.where("status = ? AND date_approve = ?", 1 , Date.current).order('date_approve DESC').paginate(:page => params[:page], :per_page => 5)
    #@collection = Request.index
  end

  def search_result

=begin
    para = "%#{params['tf_search']}%"
    id = Array.new
    @final_result = Array.new
    books_result = Book.where("book_name LIKE ?",para)
    books_result.each do |t|
      id.push(t)
    end
    id.each do |id_book|
      @request_result = Request.where("book_id = ?",id_book)
      #@final_result.push(request_result)
    end
=end
=begin
    sql = "select r.quantity, r.status, r.`date_approve`, u.`user_name`, b.`book_name`
          from requests r, books b, users u
          where b.book_name like '%Tim Tim%' AND r.book_id=b.id and r.user_id = u.id"
    @result = ActiveRecord::Base.connection.execute(sql)
=end
    para = "#{params['tf_search']}%"
    @result = Search.func_search(para)

  end
end