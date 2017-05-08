class TestController < ApplicationController
  def test_page
    # @form_for = Request.new(params[:testForm])
    collection = Book.all

  end

  def result_page
    @object = Request.new(params.require(:testForm).permit(:status, :quantity))
    @object.save
    # params.require(:testForm1).permit(:status, :quantity)
    # @status = @object[:status]
    # @abc = @testForm.new(params[:testForm])
    # @abc = params[:testForm][:status]
    # @a = @abc.status
  end

end
