module SuggestListHelper
  def func_load_detail(id)
    @suggester = Request.find(id).user.user_name
    @book_name = Request.find(id).book.book_name
    @book_link = Request.find(id).book_link
    @book_price = Request.find(id).book_price
    @book_quantity = Request.find(id).quantity
    @book_status = parse_status(Request.find(id).status)
    @date_approve = Request.find(id).date_approve
  end

  def parse_status(status)
    if status==0
      return 'Pending'
    elsif status == 1
      return 'Approved'
    else return 'Denied'
    end
  end
end
