module ServiceWelcome
  def func_post_cmt(userID,requestID,paraContent)
    #using post comment
    newObject = Comment.new
    newObject.user_id = userID
    newObject.request_id = requestID
    newObject.content = paraContent
    newObject.save!
  end

  def func_search(para)
    conditions = Hash.new
    conditions[:book] = Book.where('book_name LIKE ?', para)
    return Request.where(conditions).paginate(:page => params[:page], :per_page =>12)
  end

  def func_like(userID, requestID, like_at_begin)
    ## Case didnt like before
    checkObject = Like.where("user_id = ? AND request_id = ?",userID, requestID)
    if checkObject.blank?
      # In likes table
      likeObject = Like.new
      likeObject.user_id = userID
      likeObject.request_id = requestID
      likeObject.save!

      # In requests table
      countLike = Like.where("request_id = ? ", requestID).count
      requestObject = Request.find(requestID)
      requestObject.quantity_of_like = countLike
      requestObject.save!
      return render text:requestObject.quantity_of_like

    else
      return render text:like_at_begin
    end
    # # Case: liked before
    # # method unlike
    #   # In likes table
    #   like_id = @checkObject.ids
    #   Like.destroy(like_id)
    #   # In  requests table
    #   countLike = Like.where("user_id = ? AND request_id = ? ", userID, requestID).count
    #   @requestObject = Request.find(requestID)
    #   @requestObject.quantity_of_like = countLike
    #   @requestObject.save!
    #   return render text:@requestObject.quantity_of_like
    # end
  end

  def func_load_detail(requestID, sessionUser)
    unless sessionUser.nil?
      userID = User.find_by_user_name(session[:user]).id
      sql = "select user_name, s.*, book_name
            from users us, books b, (select r.*, if(l.request_id is NULL, false, true) as liked
                                  from requests r
                                  left join likes l
                                  on l.user_id = '#{userID}' and r.id = l.request_id
                                  where r.id = '#{requestID}') as s
            where us.id = '#{userID}' and s.book_id = b.id"
      return ActiveRecord::Base.connection.exec_query(sql)

    else
      #is anonymous
      sql = "SELECT r.*, u.user_name, b.book_name
              FROM users u, requests r, books b
              WHERE r.user_id = u.id and r.book_id = b.id and r.id = '#{requestID}'"
      return ActiveRecord::Base.connection.exec_query(sql)
    end
  end

  def func_load_comment(requestID, limit)
    sql = "select c.*, u.user_name
                      from comments c
                      left join users u
                      on c.user_id = u.id
                      where c.request_id='#{requestID}'
                      order by created_at DESC
                      LIMIT #{limit}"
    return ActiveRecord::Base.connection.exec_query(sql)
  end

  def func_create_request(userID,bookLink,bookPrice,quantity_on_request,bookName,linkImage)
    #insert exist
    if Book.find_by_book_name(bookName)
      bookID = Book.find_by_book_name(bookName).id
      insert_exists_book(bookID, userID, quantity_on_request, bookLink, bookPrice,linkImage)
      return render text: "Suggest successfully!"
    else
      #insert new book
      insert_new_book(bookName, quantity_on_request, userID, bookLink, bookPrice,linkImage)
      return render text: "Suggest successfully!"
    end
  end

  def insert_exists_book(bookID, userID, quantity_on_request, bookLink, bookPrice, linkImage)
    requestObject = Request.new
    requestObject.book_id = bookID
    requestObject.user_id = userID
    requestObject.status = 0
    requestObject.quantity = quantity_on_request
    requestObject.book_link = bookLink
    requestObject.book_price = bookPrice
    requestObject.image_link = linkImage
    requestObject.quantity_of_like = 0
    requestObject.save!

  end

  def insert_new_book(bookName, quantity_on_request, userID, bookLink, bookPrice, linkImage)
    newBook = Book.new
    newBook.book_name = bookName
    newBook.book_quantity = 0
    newBook.save!
    bookID = Book.find_by_book_name(bookName).id
    request = newBook.request.build(book_id: bookID, user_id: userID, status: 0,
                                     quantity: quantity_on_request, book_link: bookLink, book_price: bookPrice,
                                     image_link: linkImage, quantity_of_like: 0)
    if !(request.save!)
      @newBook.destroy
    end
  end

  def func_load_index_for_member(sessionUser)
    userID = User.find_by_user_name(sessionUser).id
    return Request.paginate_by_sql ['SELECT r.*, if(l.request_id is NULL, false, true) as liked
                                                    FROM requests r
                                                    LEFT JOIN likes l
                                                    ON l.user_id = ? and r.id = l.request_id
                                                    WHERE status = 0
                                                    ORDER BY created_at DESC',userID] ,:page => params[:page], :per_page => 12
  end

  def func_load_index_for_other
    return Request.where(status:0).order('created_at DESC').paginate(:page => params[:page], :per_page =>12)
  end

  def func_load_most_ranking
    return Request.order('quantity_of_like DESC').take(10)
  end

  def func_delete_comment(commentID)
    return Comment.destroy(commentID)
  end
end