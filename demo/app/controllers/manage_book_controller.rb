include ManageBookHelper

class ManageBookController < ApplicationController

  def managebook_page
    @collection = Request.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end

  def approve_page
    @collection = Request.where('status = 0').paginate(:page => params[:page], :per_page => 10)
  end


  def detail_page
    if session[:user] == 'admin'
      id = params[:id]
      @user = Request.find(id).user.user_name
      @name = Request.find(id).book.book_name
      @link = Request.find(id).book_link
      @price = Request.find(id).book_price.to_f
      @quantity = Request.find(id).quantity
    else redirect_to 'welcome/index'
    end
  end

  def management_detail_page
    if session[:user] == 'admin'
      id = params[:id]
      @request_id = id
      @suggester = Request.find(id).user.user_name
      @book_id = Request.find(id).book_id
      @book_name = Request.find(id).book.book_name
      @book_link = Request.find(id).book_link
      @book_price = Request.find(id).book_price.to_f
      @book_quantity = Request.find(id).book.book_quantity
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
      #get id from hidden form
      request_id = params['tf_request_id']

      name = params['tf_book_name']
      link = params['tf_book_link']
      price = params['tf_book_price'].to_f
      quantity = params['tf_book_quantity']
      func_update(request_id,name,link,price,quantity)
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



end
