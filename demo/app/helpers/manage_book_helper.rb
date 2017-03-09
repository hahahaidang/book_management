module ManageBookHelper
  def func_approve(id)
    book_id = Request.find(id).book_id
    @request = Request.find(id)
    @request.status = 1
    @request.date_approve = Date.current
    @book = Book.find(book_id)
    @book.book_quantity += @request.quantity
    @book.save
    @request.save
  end

  def func_deny(id)
    @action = Request.find(id)
    @action.status = 2
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
