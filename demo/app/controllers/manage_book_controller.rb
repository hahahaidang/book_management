include ManageBookHelper

class ManageBookController < ApplicationController
  before_action :check_permission

  def myrequest_page
    if @role == 0
      #only member can get in myrequest_page
      userID = User.find_by_user_name(session[:user]).id
      @collection = Request.where(id = userID).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    else
      redirect_to index_page_path
    end
  end


  def managebook_page
    if @role == 1
      @collection = Book.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
      @page =  params[:page].to_i
    else
      redirect_to index_page_path
    end
  end

  def approve_page
    if @role==1
      @collection = Request.where('status = 0').order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    else
      redirect_to index_page_path
    end
  end



  def management_detail_page
    if @role==1
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
    if @role==1
      id = params['tf_request_id']
      # get id from tf in modal
      comment = params['text_area_comment']
      # get comment from tf in modal
      if Request.find(id).status == 0
        @action = Request.new
        @action.func_approve(id,comment)
        redirect_to :back
      else
        redirect_to approve_page_path
      end
    else
      redirect_to index_page_path
    end
  end

  def deny
    if @role==1
      id = params['tf_request_id']
      # get id from tf in modal
      comment = params['text_area_comment']
      # get comment from tf in modal
      if Request.find(id).status == 0
        @action = Request.new
        @action.func_deny(id,comment)
        redirect_to :back
      else
        redirect_to approve_page_path
      end
    else
      redirect_to '/welcome/index'
    end
  end

  def update
    if @role==1
      #get id from hidden form
      book_id = params['tf_book_id']
      name = params['tf_book_name']
      quantity = params['tf_book_quantity'].to_i
      if name.blank?
        flash[:warn] = 'Bookname must not be blank!'
        redirect_to :back
      end
      if (name.length > 255)
        flash[:warn] = 'Bookname is too long'
        redirect_to :back
      end
      if (quantity <0)
        flash[:warn] = 'Invalid quantity'
        redirect_to :back
      end
      func_update(book_id, name, quantity)
      redirect_to :back
      flash[:notice] = 'Updated!'
    else
      redirect_to '/welcome/index'
    end
  end


  def delete
    if @role==1
      id = params[:id]
      func_delete(id)
      redirect_to :back
    else
      redirect_to '/welcome/index'
    end
  end

  #unuse
  def detail_page
    if @role==1
      id_request = params[:id]
      if !Request.where(id:id_request).blank?
        @collection = Request.where(id:id_request)
      else redirect_to approve_page_path
      end
    else
      redirect_to index_page_path
    end
  end
end
