include ManageBookHelper

class ManageBookController < ApplicationController

  def managebook_page
    @collection = Request.paginate(:page => params[:page], :per_page => 10)

  end

  def approve_page
    @collection = Request.paginate(:page => params[:page], :per_page => 10)

  end


  def detail_page
    if session[:user] == 'admin'
      id = params[:id]
      @user = Request.find(id).user.user_name
      @name = Request.find(id).book.book_name
      @link = Request.find(id).book.book_link
      @description = Request.find(id).book.book_description
      @price = Request.find(id).book.book_price.to_f
      @quantity = Request.find(id).quantity
    else redirect_to 'welcome/index'
    end
  end

  def management_detail_page
    if session[:user] == 'admin'
      id = params[:id]
      @suggester = Request.find(id).user.user_name
      @book_id = Book.find(id).id
      @book_name = Book.find(id).book_name
      @book_link = Book.find(id).book_link
      @book_description = Book.find(id).book_description
      @book_price = Book.find(id).book_price.to_f
      @book_quantity = Book.find(id).book_quantity
    else redirect_to 'welcome/index'
    end
  end

  def approve
    if session[:user] == 'admin'
      if request.get?
        id = params[:id]
      end
      @action = Request.new
      @action.func_approve(id)
      redirect_to :back
    else redirect_to 'welcome/index'
    end
  end

  def deny
    if session[:user] == 'admin'
      if request.get?
        id = params[:id]
      end
      @action = Request.new
      @action.func_deny(id)
      redirect_to :back
    else redirect_to 'welcome/index'
    end
  end

  def update
    if session[:user] == 'admin'
      id = params['tf_book_id']
      name = params['tf_book_name']
      link = params['tf_book_link']
      description = params['tf_book_description']
      price = params['tf_book_price'].to_f
      quantity = params['tf_book_quantity']
      func_update(id,name,link,description,price,quantity)
      redirect_to :back
      flash[:notice] = 'Updated!'
    else redirect_to 'welcome/index'
    end
  end

  def delete
    if session[:user] == 'admin'
      id = params[:id]
      func_delete(id)
      redirect_to :back
    else redirect_to 'welcome/index'
    end
  end

  def unapprove
    if session[:user] == 'admin'
      id = params[:id]
      func_unapprove(id)
      redirect_to :back
    else redirect_to 'welcome/index'
    end
  end

end
