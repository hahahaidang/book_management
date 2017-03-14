include SuggestHelper

class SuggestController < ApplicationController
  def suggest_page
    if session[:user] == nil
      redirect_to login_page_path
    end
  end

  def create_suggestion
    if session[:user]
      userID = User.find_by_user_name(session[:user]).id
      bookLink = params['tf_book_link']
      bookPrice = params['tf_book_price'].to_f
      quantity_on_request = params['tf_book_quantity'].to_i
      bookName = params['tf_book_name']
      if bookName.blank?
        flash[:warn] = 'Bookname must not be blank!'
      else
        if (bookName.length > 255)
          flash[:warn] = 'Bookname is too long!'
        else
          if (bookLink.length > 255)
            flash[:warn] = 'Booklink is too long!'
          else
            if (bookPrice == 0.0)
              flash[:warn] = 'Invalid price!'
            else
              if (bookPrice < 0) || (bookPrice > 1000)
                flash[:warn] = 'Price must be greater than 0 and less than or equal 1000'
              else
                if (quantity_on_request == 0)
                  flash[:warn] ='Invalid quantity!'
                else
                  if (quantity_on_request < 0) || (quantity_on_request > 100)
                    flash[:warn] = 'Quantity must be greater than 0 and less than or elqual 100'
                  else
                    #insert exist
                    if Book.find_by_book_name(bookName)
                      bookID = Book.find_by_book_name(bookName).id
                      insert_exists_book(bookID, userID, quantity_on_request, bookLink, bookPrice)
                      flash[:notice] = 'Insert success!'
                    else
                      #insert new book
                      insert_new_book(bookName, quantity_on_request, userID, bookLink, bookPrice)
                      flash[:notice] = 'Insert success!'
                    end
                  end
                end
              end
            end
          end
        end
      end

      # if check_input_controller(bookName, bookLink, bookPrice,quantity_on_request)
      #   #insert book exist
      #   if Book.find_by_book_name(bookName)
      #     bookID = Book.find_by_book_name(bookName).id
      #     insert_exists_book(bookID, userID, quantity_on_request, bookLink, bookPrice)
      #     flash[:notice] = 'Insert success!'
      #   else
      #     #insert new book
      #     insert_new_book(bookName, quantity_on_request, userID, bookLink, bookPrice)
      #     flash[:notice] = 'Insert success!'
      #   end
      # else
      #   flash[:warn] = 'Invalid input'
      # end
      redirect_to :back
    else
      redirect_to login_page_path
    end
  end

  def list_book
    sql = "SELECT book_name FROM books"
    @result = ActiveRecord::Base.connection.exec_query(sql)
    return render json: @result

  end

end
