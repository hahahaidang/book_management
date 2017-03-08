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

  def func_update(book_id, name, quantity)

    @request = Book.find(book_id)
    @request.book_name = name
    @request.book_quantity = quantity
    @request.save
  end

  def func_delete(book_id)
    @actionRequest = Request.find_by_book_id(book_id)
    @actionRequest.destroy
    @actionBook = Book.find(book_id)
    @actionBook.destroy
  end
end
