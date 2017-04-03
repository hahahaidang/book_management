require 'will_paginate/array'
include WelcomeHelper

class WelcomeController < ApplicationController
  before_action :check_permission

  def index
    @page_title = 'Index page'

    if @role == 0
      #if member
      userID = User.find_by_user_name(session[:user]).id
      @collection_list_suggestion = Request.paginate_by_sql ['select r.*, if(l.request_id is NULL, false, true) as liked
                            from requests r
                            left join likes l
                            on l.user_id = ? and r.id = l.request_id
                            where status = 0',userID] ,:page => params[:page], :per_page => 12

      #list request and rank by quantity of like, just take 10
      @collection_most_ranking = Request.order('quantity_of_like DESC').take(10)
    else
      #admin or anonymous
      @collection_list_suggestion = Request.where(status:0).paginate(:page => params[:page])
      @collection_most_ranking = Request.order('quantity_of_like DESC').take(10)

    end

  end

  def post_comment
    #using: post comment
    if !(session[:user].nil?)
      user_name = session[:user]
      userID = User.find_by_user_name(user_name).id
    else
      userID = nil
    end
    content = params['comment_text_area'];
    requestID = params[:id];

    if content.blank?
      #if content is nil
      flash[:warn] = 'Comment must not be blank!'
      redirect_to :back
      return false
    end
    if content.length > 255
      #value is greater than 255
      flash[:warn] = 'Comment must less than 255'
      redirect_to :back
      return false
    end
    if func_post_cmt(userID,requestID,content)
      #if post comment successlfully
      redirect_to :back
    end
  end

  def search_result
    #function search
    @value_search = params['tf_search']
    para = "%#{params['tf_search']}%"
    @result = Request.paginate_by_sql ['select r.id, r.quantity, r.status, r.created_at, u.user_name, b.book_name
          from requests r, books b, users u
          where b.book_name like ? AND r.book_id=b.id and r.user_id = u.id', para], :page => params[:page], :per_page => 10
  end

  def like
    #using: increase like of item
    if session[:user].nil? || @role == 1
      #if anonymous or admin
      #check nil
      redirect_to login_page_path
    end

    requestID = params[:id]
    suggester = session[:user]

    if @role == 0
      userID = User.find_by_user_name(suggester).id
      #if is Member
      like_at_begin = Request.find(requestID).quantity_of_like
      ## Case didnt like before
      ### method like
      @checkObject = Like.where("user_id = ? AND request_id = ?",userID, requestID)
      if @checkObject.blank?
        #### In likes table
        @likeObject = Like.new
        @likeObject.user_id = userID
        @likeObject.request_id = requestID
        @likeObject.save!

        #### In requests table
        countLike = Like.where("user_id = ? AND request_id = ? ", userID, requestID).count
        @requestObject = Request.find(requestID)
        @requestObject.quantity_of_like = countLike
        @requestObject.save!

        return render text:@requestObject.quantity_of_like
      else
        return render text:like_at_begin
      end
      # # Case: liked before
      # # method unlike
      #   # In likes table
      #   like_id = @checkObject.ids
      #   Like.destroy(like_id)
      #   # In  requests table
      #   countLike = Like.where("user_id = ? AND request_id = ? ", userID, requestID).count
      #   @requestObject = Request.find(requestID)
      #   @requestObject.quantity_of_like = countLike
      #   @requestObject.save!
      #   return render text:@requestObject.quantity_of_like
      # end
    end
  end

  def detail
    request_id = params[:id]
    if !(session[:user].nil?)
      #if user or admin
      userID = User.find_by_user_name(session[:user]).id
      sql = "select user_name, s.*, book_name
            from users us, books b, (select r.*, if(l.request_id is NULL, false, true) as liked
                                  from requests r
                                  left join likes l
                                  on l.user_id = '#{userID}' and r.id = l.request_id
                                  where r.id = '#{request_id}') as s
            where us.id = '#{userID}' and s.book_id = b.id"
      @collection =  ActiveRecord::Base.connection.exec_query(sql)

    else
      #is anonymous
      sql = "select r.*, u.user_name, b.book_name
              from users u, requests r, books b
              where r.user_id = u.id and r.book_id = b.id and r.id = '#{request_id}'"
      @collection = ActiveRecord::Base.connection.exec_query(sql)

    end
    sqlComment = "select c.*, u.user_name
                      from comments c
                      left join users u
                      on c.user_id = u.id
                      where c.request_id='#{request_id}'
                      order by created_at DESC
                      LIMIT 10"
    @comment = ActiveRecord::Base.connection.exec_query(sqlComment)
  end

  def review_request
    #modal review request
    if @role == 0
      # is member
      return render layout: false, template: "welcome/review_request"
    else redirect_to index_page_path
    end

  end



  def suggest_form
    #modal suggest_form
    if @role == 0
      # is member
      return render layout: false, template: "welcome/suggest_form"
    else redirect_to index_page_path
    end

  end




  def create_request
    #create new request
    if  @role == 0
      # is member
      userID = User.find_by_user_name(session[:user]).id
      bookLink = params['tf_book_link']
      bookPrice = params['tf_book_price'].to_f
      quantity_on_request = params['tf_book_quantity'].to_i
      bookName = params['tf_book_name'].strip
      linkImage = params['tf_link_image']

      # if book.blank?
      #   flash[:warn] = 'Bookname must not be blank!'
      #   return false
      # end









      if bookName.blank?
        flash[:warn] = 'Bookname must not be blank!'
      else
        if (bookName.length > 255)
          flash[:warn] = 'Bookname is too long!'
        else
          if (bookLink.length > 400)
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
                    else
                      #insert new book
                      insert_new_book(bookName, quantity_on_request, userID, bookLink, bookPrice,linkImage)
                    end
                  end
                end
              end
            end
          end
        end
      end
      return render text: "Suggest successfully!"
    else
      redirect_to login_page_path
    end
  end
end