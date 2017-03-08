module ManageBookHelper
  def func_approve(id)
    @action = Request.find(id)
    @action.status = 1
    @action.date_approve = Date.current
    @action.save
  end

  def func_deny(id)
    @action = Request.find(id)
    @action.status = 2
    @action.date_approve = ''
    @action.save
  end

  def func_unapprove(id)
    @action = Request.find(id)
    @action.status = 0
    @action.date_approve= ''
    @action.save
  end

  def func_update(request_id, name, link, price, quantity)

    @request = Request.find(request_id)
    @request.book_price = price
    @request.quantity = quantity
    @request.book_link = link
    @request.book.book_name = name
    bookID = Request.find(request_id).book_id
    @book = Book.find(bookID)
    @book.book_name = name

    @request.save
    @book.save
  end

  def func_delete(id)
    @actionRequest = Request.find_by_book_id(id)
    @actionRequest.destroy
    @actionBook = Book.find(id)
    @actionBook.destroy
  end
end
