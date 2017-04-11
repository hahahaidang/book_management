class TestController < ApplicationController
  def test_page
    @request =  Request.paginate(:page => params[:page], :per_page => 14)

  end


end
