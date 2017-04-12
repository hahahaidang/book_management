module ServiceManageBook
  def func_approve(request_id,admin_comment)
      book_id = Request.find(request_id).book_id
      @request = Request.find(request_id)
      @request.status = 1
      @request.date_approve =  Time.now.to_datetime
      @request.admin_comment = admin_comment
      @book = Book.find(book_id)
      @book.book_quantity += @request.quantity
      return true if @book.save! && @request.save!
  end

  def func_deny(request_id, adm_comment)
      @action = Request.find(request_id)
      @action.status = 2
      @action.admin_comment = adm_comment
      return true if @action.save!
  end

  def func_update(book_id, name, quantity)
      @request = Book.find(book_id)
      @request.book_name = name
      @request.book_quantity = quantity
      return true if @request.save!
  end

  def func_delete(bookID)
    unless Book.where(id:bookID).blank?
      Request.destroy_all(book_id:bookID)
      Book.destroy(bookID)
      return true
    end
  end

  def func_load_myrequest(sessionUSer, inputStatus)
    userID = User.find_by_user_name(sessionUSer).id
    return Request.my_request(userID, inputStatus).paginate(:page => params[:page], :per_page => 10)
  end

  def func_cancel_request(userID, requestID)
    #if found request belongs to this member
    unless (Request.where('user_id = ? AND id= ? ',userID,requestID)).blank?
      Request.destroy(requestID) ? (return true) : (return false)
    end
  end

  def func_load_managebook
    return Book.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end

  def func_load_approve_page(para_search_type, para_from_tf)
    if para_search_type.nil? && para_from_tf.nil?
      #if type is nil, return default collection
      return @collection = Request.pending_request.paginate(:page => params[:page], :per_page => 10)

    else
      #get params
      search_type = para_search_type.to_i
      input = para_from_tf

      conditions = Hash.new
      case search_type
        #search by username
        when 0
          conditions[:user] = User.user_like input

        #search by bookname
        when 1
          conditions[:book] = Book.book_like input
      end
      return @collection = Request.where(conditions).where(status:0).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    end
  end

  def func_load_management_detail(book_id)
    return Book.where(id:book_id) unless Book.where(id:book_id).blank?
  end
end