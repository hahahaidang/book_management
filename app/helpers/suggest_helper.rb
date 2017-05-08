module SuggestHelper

  def insert_exists_book(bookID, userID, quantity_on_request, bookLink, bookPrice, linkImage)
    @requestObject = Request.new
    @requestObject.book_id = bookID
    @requestObject.user_id = userID
    @requestObject.status = 0
    @requestObject.quantity = quantity_on_request
    @requestObject.book_link = bookLink
    @requestObject.book_price = bookPrice
    @requestObject.image_link = linkImage
    @requestObject.quantity_of_like = 0
    @requestObject.save!

  end

  def insert_new_book(bookName, quantity_on_request, userID, bookLink, bookPrice, linkImage)
    @newBook = Book.new
    @newBook.book_name = bookName
    @newBook.book_quantity = 0
    @newBook.save!
    bookID = Book.find_by_book_name(bookName).id
    request = @newBook.request.build(book_id: bookID, user_id: userID, status: 0,
                                     quantity: quantity_on_request, book_link: bookLink, book_price: bookPrice,
                                     image_link: linkImage, quantity_of_like: 0)
    if !(request.save!)
      @newBook.destroy
    end
  end



  def check_input_controller(name, link, price, quantity)
    flag = 0
    unless (name.length > 255)
      unless (link.length > 255)
        unless price.blank?
          if price.class == Float
            unless !quantity.blank?
              if quantity.class == Fixnum
                flag = 1
              end
            end
          end
        end
      end
    end

    if flag == 1
      return true
    else return false
    end
  end



end
