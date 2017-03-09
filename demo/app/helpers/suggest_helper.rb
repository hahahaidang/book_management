module SuggestHelper

  def insert_exists_book(bookID,userID,quantity_on_request,bookLink,bookPrice)
    @requestObject = Request.new
    @requestObject.book_id = bookID
    @requestObject.user_id = userID
    @requestObject.status = 0
    @requestObject.quantity = quantity_on_request
    @requestObject.book_link = bookLink
    @requestObject.book_price = bookPrice
    @requestObject.save
    @bookObject = Book.find(bookID)
    @bookObject.save

  end
  def insert_new_book(bookName,quantity_on_request,userID,bookLink,bookPrice)
    @newBook = Book.new
    @newBook.book_name = bookName
    @newBook.book_quantity = 0
    @newBook.save
    bookID = Book.find_by_book_name(bookName).id
    request = @newBook.request.build(book_id: bookID, user_id: userID, status: 0,
                                     quantity: quantity_on_request, book_link: bookLink, book_price: bookPrice)
    request.save
  end


end
