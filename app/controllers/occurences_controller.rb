class OccurencesController < ApplicationController
  def show
    @fail = Fail.find(params[:fail_id])
    @occurence = @fail.occurences.find(params[:id])
    render :partial => 'fails/occurence', :object => @occurence
  end
end