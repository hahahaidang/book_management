class WelcomeController < ApplicationController
  def index
    @page_title = 'Index page'
    @collection = Request.where('status = 1').order('date_approve DESC').paginate(:page => params[:page], :per_page => 5)

  end

end
