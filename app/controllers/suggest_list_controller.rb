include SuggestListHelper
class SuggestListController < ApplicationController
  before_action :check_permission
  def suggest_list_page
    @collection = Request.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
  end


  def detail_suggest_list_page
    id = params[:id]
    func_load_detail(id)
  end

end
