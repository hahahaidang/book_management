include ManageBookHelper

class ManageBookController < ApplicationController

  def managebook_page
    if session[:user]=='admin'
      @collection = Book.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    else
      redirect_to '/welcome/index'
    end
  end

  def approve_page
    if session[:user] == 'admin'
     @collection = Request.where('status = 0').paginate(:page => params[:page], :per_page => 10)
    else
      redirect_to '/welcome/index'
    end
  end


  def detail_page
    if session[:user] == 'admin'
      id = params[:id]
      @user = Request.find(id).user.user_name
      @name = Request.find(id).book.book_name
      @link = Request.find(id).book_link
      @price = Request.find(id).book_price.to_f
      @quantity = Request.find(id).quantity
    else redirect_to '/welcome/index'
    end
  end

  def management_detail_page
    if session[:user] == 'admin'
      id = params[:id]
      @book_id = id
      @book_name = Book.find(id).book_name
      @book_quantity = Book.find(id).book_quantity
    else redirect_to '/welcome/index'
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
    else redirect_to '/welcome/index'
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
    else redirect_to '/welcome/index'
    end
  end

  def update
    if session[:user] == 'admin'
      #get id from hidden form
      book_id = params['tf_book_id']
      name = params['tf_book_name']
      quantity = params['tf_book_quantity']
      func_update(book_id,name,quantity)
      redirect_to :back
      flash[:notice] = 'Updated!'
    else redirect_to '/welcome/index'
    end
  end

  def delete
    if session[:user] == 'admin'
      id = params[:id]
      func_delete(id)
      redirect_to :back
    else redirect_to '/welcome/index'
    end
  end



end
