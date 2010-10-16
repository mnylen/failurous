class FailsController < ApplicationController
  
  def show
    @fail = Fail.find(params[:id])
  end

end
