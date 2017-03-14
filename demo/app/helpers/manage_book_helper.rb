module ManageBookHelper
  def func_approve(request_id)
    if !Request.where(id:request_id).blank?
      book_id = Request.find(request_id).book_id
      @request = Request.find(request_id)
      @request.status = 1
      @request.date_approve =  Time.now.to_datetime
      @book = Book.find(book_id)
      @book.book_quantity += @request.quantity
      @book.save!
      @request.save!
    else
      redirect_to approve_page_path
    end
  end

  def func_deny(request_id)
    if !Request.where(id:request_id).blank?
      @action = Request.find(request_id)
      @action.status = 2
      @action.save!
    else
      redirect_to approve_page_path
    end
  end

  def func_update(book_id, name, quantity)
    if !Book.where(id:book_id).blank?
      @request = Book.find(book_id)
      @request.book_name = name
      @request.book_quantity = quantity
      @request.save!
    else
      redirect_to managebook_page_path
    end
  end

  def func_delete(bookID)
    if !Book.where(id:bookID).nil?
      Request.destroy_all(book_id:bookID)
      Book.destroy(bookID)
    else
      redirect_to managebook_page_path
    end
  end

end
