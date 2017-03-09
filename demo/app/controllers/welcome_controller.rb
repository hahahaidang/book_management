require 'date'

class WelcomeController < ApplicationController
  def index
    @page_title = 'Index page'
    beginDate = Date.current.beginning_of_day
    endDate = Date.current.end_of_day
    if session[:user]=='admin'
      @collection = Request.where("status = ? AND created_at >= ? AND created_at < ?", 0, beginDate, endDate)
                        .order('created_at DESC').paginate(:page => params[:page], :per_page =>5)

    else
      @collection = Request.where("status = ? AND date_approve >= ? AND created_at < ?", 1 , beginDate, endDate)
                        .order('date_approve DESC').paginate(:page => params[:page], :per_page => 5)


    end
  end

  def search_result
    para = "%#{params['tf_search']}%"
    @result = Search.func_search(para)
  end
end