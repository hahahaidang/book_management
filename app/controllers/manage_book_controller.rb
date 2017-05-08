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
    #is admin
    if @role==1
      book_id = params[:id]
      if func_load_management_detail(book_id).blank?
        redirect_to managebook_page_path
      else
        @collection = func_load_management_detail(book_id)
      end

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
      return render nothing:true, status:200 if func_update(book_id, name, quantity)

    else
      #is not admin
      redirect_to index_page_path
    end
  end

  def delete
    #is admin
    if @role==1
      id = params[:id]
      redirect_to :back if func_delete(id)

    else
      #is not admin
      redirect_to index_page_path
    end
  end

  def modal_detail
    if @role == 1 && !params[:book_id].blank?
      bookID = params[:book_id]
      @collection = Book.where(id:bookID)
      return render layout:false, template: "manage_book/modal_detail"
    else
      redirect_to index_page_path
    end
  end

  private
  def before_update
    name = params['tf_book_name']
    quantity = params['tf_book_quantity'].to_i

    #validation
    return render status:500 if name.blank?
    return render status:500 if name.length > 255
    return render status:500 if quantity < 0 || quantity.blank?
  end
end
