require 'will_paginate/array'

class WelcomeController < ApplicationController
  def index
    @page_title = 'Index page'
    beginDate = Date.current.beginning_of_day
    endDate = Date.current.end_of_day
    if session[:user]=='admin'
      @collection = Request.where("status = ? AND created_at >= ? AND created_at < ?", 0, beginDate, endDate)
                        .order('created_at DESC').paginate(:page => params[:page], :per_page => 5)

    else
      @collection = Request.where("status = ? AND date_approve >= ? AND created_at < ?", 1, beginDate, endDate)
                        .order('date_approve DESC').paginate(:page => params[:page], :per_page => 5)


    end
  end

  def search_result
    @value_search = params['tf_search']
    para = "%#{params['tf_search']}%"
    @result = Request.paginate_by_sql ['select r.quantity, r.status, r.created_at, u.user_name, b.book_name
          from requests r, books b, users u
          where b.book_name like ? AND r.book_id=b.id and r.user_id = u.id', para], :page => params[:page], :per_page => 10
  end
end