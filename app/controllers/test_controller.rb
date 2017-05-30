require "#{Rails.root}/app/controllers/concerns/constants.rb"



class TestController < ApplicationController

  def test_page
    @form_for = Request.new(params[:testForm])
    @const = Constants::MAX_LENGTH_USERNAME


  end

  def result_page
    @object = Request.new(params.require(:testForm).permit(:status, :quantity))
    @object.save
    # params.require(:testForm1).permit(:status, :quantity)
    # if (@status < Constants::QUANTITY_TEST)
    #   @status = 3
    # end

    @const = Constants::QUANTITY_TEST
    @status = @object[:status]
    @quantity = @object[:quantity]
    # @abc = @testForm.new(params[:testForm])
    # @abc = params[:testForm][:status]
    # @a = @abc.status
  end



end
