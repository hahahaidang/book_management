include ManageBookHelper

class ManageBookController < ApplicationController

  def managebook_page
    if session[:user]=='admin'
      @collection = Book.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
      @page =  params[:page].to_i

    else
      redirect_to index_page_path
    end
  end

  def approve_page
    if session[:user] == 'admin'
      @collection = Request.where('status = 0').paginate(:page => params[:page], :per_page => 10)
    else
      redirect_to index_page_path
    end
  end


  def detail_page
    if session[:user] == 'admin'
      id_request = params[:id]
      if !Request.where(id:id_request).blank?
       @collection = Request.where(id:id_request)
      else redirect_to approve_page_path
      end
    else
      redirect_to index_page_path
    end
  end

  def management_detail_page
    if session[:user] == 'admin'
      book_id = params[:id]
      if !Book.where(id:book_id).blank?
        @collection = Book.where(id:book_id)
      else
        redirect_to managebook_page_path
      end
    else
      redirect_to index_page_path
    end
  end

  def approve
    if session[:user] == 'admin'
      if request.get?
        id = params[:id]
      end
      if Request.find(id).status == 0
        @action = Request.new
        @action.func_approve(id)
        redirect_to :back
      else
        redirect_to approve_page_path
      end

    else
      redirect_to index_page_path
    end
  end

  def deny
    if session[:user] == 'admin'
      if request.get?
        id = params[:id]
      end
      if Request.find(id).status == 0
        @action = Request.new
        @action.func_deny(id)
        redirect_to :back
      else
        redirect_to approve_page_path
      end

    else
      redirect_to '/welcome/index'
    end
  end

  def update
    if session[:user] == 'admin'
      #get id from hidden form
      book_id = params['tf_book_id']
      name = params['tf_book_name']
      quantity = params['tf_book_quantity'].to_i
      if name.blank?
        flash[:warn] = 'Bookname must not be blank!'
        redirect_to :back
      else
        if (name.length > 255)
          flash[:warn] = 'Bookname is too long'
          redirect_to :back
        else
          if (quantity <0)
            flash[:warn] = 'Invalid quantity'
            redirect_to :back
          else
            func_update(book_id, name, quantity)
            redirect_to :back
            flash[:notice] = 'Updated!'
          end
        end
      end
    else
      redirect_to '/welcome/index'
    end
  end

  def delete
    if session[:user] == 'admin'
      id = params[:id]
      func_delete(id)
      redirect_to :back
    else
      redirect_to '/welcome/index'
    end
  end


end
