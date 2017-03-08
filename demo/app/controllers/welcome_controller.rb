class WelcomeController < ApplicationController
  def index
    @page_title = 'Index page'
    @collection = Request.where("status = ? AND date_approve = ?", 1 , Date.current).order('date_approve DESC').paginate(:page => params[:page], :per_page => 5)
    #@collection = Request.index
  end

  def search_result
    para = "%#{params['tf_search']}%"
    @result = Search.func_search(para)

  end
end