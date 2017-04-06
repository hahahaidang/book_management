module SuggestListHelper
  def func_load_detail(id)
    if !Request.where(id:id).blank?
      request = Request.find(id)
      @suggester = request.user.user_name
      @book_name = request.book.book_name
      @book_link = request.book_link
      @book_price = request.book_price
      @book_quantity = request.quantity
      @book_status = parse_status(request.status)
      @date_approve = request.date_approve
    end
  end

  def parse_status(status)
    if status==0
      return 'Pending'
    elsif status == 1
      return 'Approved'
    else
      return 'Denied'
    end
  end
end
