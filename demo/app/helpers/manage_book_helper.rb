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

  def func_update(id, name, link, description, price, quantity)
    @action = Book.find(id)
    @action.book_name = name
    @action.book_link = link
    @action.book_description = description
    @action.book_price = price
    @action.book_quantity = quantity
    @action.save
  end

  def func_delete(id)
    @actionRequest = Request.find_by_book_id(id)
    @actionRequest.destroy
    @actionBook = Book.find(id)
    @actionBook.destroy
  end
end
