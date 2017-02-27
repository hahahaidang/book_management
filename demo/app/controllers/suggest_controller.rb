class SuggestController < ApplicationController
  include SuggestHelper
  def suggest_page

  end

  def create_suggestion
    if (session[:user] !=nil)
      @newBook = Book.new
      @newBook.halfInsertBook(params['tf_book_name'], params['tf_book_link'], params['tf_book_description'], params['tf_book_price'], params['tf_book_quantity'])
      userID = User.find_by_user_name(session[:user]).id
      bookID = Book.find_by_book_name(params['tf_book_name']).id
      request = @newBook.request.build(book_id: bookID, user_id: userID, status: 0)
      request.save
      flash[:notice] = 'Insert success!'
      redirect_to :back
    else
      redirect_to 'login/login_page'
    end
  end



end
