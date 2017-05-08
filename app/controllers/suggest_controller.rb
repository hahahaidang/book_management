include SuggestHelper
class SuggestController < ApplicationController
  before_action :check_permission
  def suggest_page
    if session[:user].nil?
      redirect_to login_page_path
    end
  end

  def create_suggestion
    if @role == 0
      userID = User.find_by_user_name(session[:user]).id
      bookLink = params['tf_book_link']
      bookPrice = params['tf_book_price'].to_f
      quantity_on_request = params['tf_book_quantity'].to_i
      bookName = params['tf_book_name'].strip
      linkImage = params['tf_link_image']
      if bookName.blank?
        flash[:warn] = 'Bookname must not be blank!'
      else
        if (bookName.length > 255)
          flash[:warn] = 'Bookname is too long!'
        else
          if (bookLink.length > 600)
            flash[:warn] = 'Booklink is too long!'
          else
            if (bookPrice == 0.0)
              flash[:warn] = 'Invalid price!'
            else
              if (bookPrice < 0)
                flash[:warn] = 'Price must be greater than or equal 0!'
              else
                if (quantity_on_request == 0)
                  flash[:warn] ='Invalid quantity!'
                else
                  if (quantity_on_request < 0)
                    flash[:warn] = 'Quantity must be a positive number!'
                  else
                    #insert exist
                    if Book.find_by_book_name(bookName)
                      bookID = Book.find_by_book_name(bookName).id
                      insert_exists_book(bookID, userID, quantity_on_request, bookLink, bookPrice,linkImage)
                      flash[:notice] = 'Suggest successfully!'
                    else
                      #insert new book
                      insert_new_book(bookName, quantity_on_request, userID, bookLink, bookPrice,linkImage)
                      flash[:notice] = 'Suggest successfully!'
                    end
                  end
                end
              end
            end
          end
        end
      end
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
