include SuggestHelper

class SuggestController < ApplicationController
  def suggest_page
    if session[:user] == nil
      redirect_to '/login/login_page'
    end
  end

  def create_suggestion
    if session[:user]
      userID = User.find_by_user_name(session[:user]).id
      bookLink = params['tf_book_link']
      bookPrice = params['tf_book_price']
      quantity_on_request = Integer(params['tf_book_quantity'])
      bookName = params['tf_book_name']
      #insert book exist
      if Book.find_by_book_name(bookName)
        bookID = Book.find_by_book_name(bookName).id
        insert_exists_book(bookID,userID,quantity_on_request,bookLink,bookPrice)
        flash[:notice] = 'Insert success!'
      else
      #insert new book
        insert_new_book(bookName,quantity_on_request,userID,bookLink,bookPrice)
        flash[:notice] = 'Insert success!'
      end
      redirect_to :back
    else
      redirect_to '/login/login_page'
    end
  end

    def list_book
      sql = "SELECT book_name FROM books"
      @result = ActiveRecord::Base.connection.exec_query(sql)
      return render json: @result

    end

  end
