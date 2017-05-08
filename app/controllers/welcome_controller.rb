require 'will_paginate/array'
include ServiceWelcome

class WelcomeController < ApplicationController
  before_action :check_permission
  before_action :before_create, only:[:create_request]

  def index
    @page_title = 'Index page'

    #if member
    if @role == 0
      @collection_list_suggestion = func_load_index_for_member(session[:user])
    else
      #admin or anonymous
      @collection_list_suggestion = func_load_index_for_other

    end
    @collection_most_ranking = func_load_most_ranking

  end

  def search_result
    #function search
    para = "#{params['tf_search']}%"
    @result = func_search(para)
  end

  def like
    #if anonymous or admin
    (redirect_to login_page_path) if (session[:user].nil? || @role == 1)

    requestID = params[:id]
    suggester = session[:user]

    #is member
    if @role == 0
      userID = User.find_by_user_name(suggester).id
      like_at_begin = Request.find(requestID).quantity_of_like
      return func_like(userID, requestID, like_at_begin)
    end
  end

  def detail
    request_id = params[:id]

    #default is 5
    if params[:quantity_of_comment].nil?
      quantity_of_comment = 5
    else
      quantity_of_comment = params[:quantity_of_comment]
    end
     @collection = func_load_detail(request_id, session[:user])
     @comment = func_load_comment(request_id, quantity_of_comment)
  end

  #modal review request
  def review_request
    #is member
    @role == 0 ? (return render layout: false, template: "welcome/review_request") :  (redirect_to index_page_path)
  end

  #modal suggest_form
  def suggest_form
    #is member
    @role == 0 ? (return render layout: false, template: "welcome/suggest_form") : (redirect_to index_page_path)
  end

  def create_request
    # is member
    if  @role == 0
      userID = User.find_by_user_name(session[:user]).id
      bookLink = params['tf_book_link']
      bookPrice = params['tf_book_price'].to_f
      quantity_on_request = params['tf_book_quantity'].to_i
      bookName = params['tf_book_name'].strip
      linkImage = params['tf_link_image']

      return func_create_request(userID, bookLink, bookPrice, quantity_on_request, bookName, linkImage)
    else
      redirect_to login_page_path
    end
  end

  def post_comment
    #session not nil
    if session[:user].nil?
      userID = nil
    else
      user_name = session[:user]
      userID = User.find_by_user_name(user_name).id
    end

    content = params['comment_text_area']
    requestID = params['hidden_id_request']

    return render status:500 if content.blank? || content.length > 255
    if func_post_cmt(userID,requestID,content)
      @comment = func_load_comment(requestID,5)
      return render layout:false, template: "welcome/load_comment"
    end
  end

  def load_more_comment
    @requestId = params[:requestId].to_i
    quantity_of_comment = params[:quantity_of_comment].to_i
    if quantity_of_comment < Comment.where(request_id:@requestId).count
      @hasLeft = true
    end
    @comment = func_load_comment(@requestId, quantity_of_comment)
    return render layout:false, template: "welcome/load_comment"

  end


  def delete_comment
    #check role, only admin can use
    if @role == 1
      commentID = params[:comment_id]
      requestID = Comment.find(commentID).request_id
      if func_delete_comment(commentID)
        @comment = func_load_comment(requestID,5)
        return render layout:false, template: "welcome/delete_comment"
      end

    else
      redirect_to index_page_path
    end
  end


  private
    def before_create
      bookPrice = params['tf_book_price'].to_f
      #validation
      #bookname is blank
      return render status:500 if params['tf_book_name'].strip.blank?
      return render status:500 if params['tf_book_link'].length > 600
      return render status:500 if bookPrice == 0.0 || bookPrice < 0
      return render status:500 if params['tf_book_quantity'].to_i <= 0
    end
end