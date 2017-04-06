include ServiceManageBook

class ManageBookController < ApplicationController
  before_action :check_permission
  before_action :before_update, only: [:update]

  def myrequest_page
    #only member can get in myrequest_page
    if @role == 0
      #default status is 0
      params[:status].nil? ? inputStatus = 0 : inputStatus = params[:status]
      @collection = func_load_myrequest(session[:user], inputStatus)
    else
      redirect_to index_page_path
    end
  end

  def cancel_request
    if @role == 0
      userID = User.find_by_user_name(session[:user]).id
      requestID = params[:id]
      func_cancel_request(userID, requestID) ? (redirect_to :back) : (redirect_to index_page_path)
    else
      #if is not member
      redirect_to index_page_path
    end
  end

  def managebook_page
    if @role == 1
      #is admin
      @collection = func_load_managebook
      @page =  params[:page].to_i
    else
      redirect_to index_page_path
    end
  end

  def approve_page
    #is admin
    if @role==1
      @collection = func_load_approve_page(params['search_type'], params['tf_search_admin'])
    else
      #is not admin redirect to index
      redirect_to index_page_path
    end
  end



  def management_detail_page
    if @role==1
      book_id = params[:id]
      @collection = func_load_management_detail(book_id)

    else
      redirect_to index_page_path
    end
  end

  def approve
    #is admin
    if @role==1
      # get id and comment from tf in modal
      id = params['tf_request_id']
      comment = params['text_area_comment']

      #only request has status = 0 can be approved
      if Request.find(id).status == 0
        redirect_to :back if func_approve(id,comment)


      #status isn't equal 0, redirect to approve_page
      else
        redirect_to approve_page_path
      end

    else
      #is not admin redirect to index
      redirect_to index_page_path
    end
  end

  def deny
    #is admin
    if @role==1
      # get id and comment from tf in modal
      id = params['tf_request_id']
      comment = params['text_area_comment']

      #only request has status = 0 can be denied
      if Request.find(id).status == 0
        func_deny(id,comment)
        redirect_to :back

      else
        redirect_to approve_page_path
      end

    else
      redirect_to '/welcome/index'
    end
  end

  def update
    #is admin
    if @role==1
      #get value from hidden form
      book_id = params['tf_book_id']
      name = params['tf_book_name']
      quantity = params['tf_book_quantity'].to_i

      if func_update(book_id, name, quantity)
        redirect_to :back
        flash[:notice] = 'Updated!'
      end

    else
      #is not admin
      redirect_to '/welcome/index'
    end
  end

  def delete
    #is admin
    if @role==1
      id = params[:id]
      redirect_to :back if func_delete(id)

    else
      #is not admin
      redirect_to '/welcome/index'
    end
  end

  #unuse
  def detail_page
    if @role==1
      id_request = params[:id]
      !(Request.where(id:id_request).blank?) ? @collection = Request.where(id:id_request) : (redirect_to approve_page_path)


    else
      redirect_to index_page_path
    end
  end

  private
  def before_update
    name = params['tf_book_name']
    quantity = params['tf_book_quantity'].to_i

    #validation
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
  end
end
