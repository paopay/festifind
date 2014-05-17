class HomeController < ApplicationController
  def index
  	if params[:location]
  		@festivals = Festival.all
  	else
  		@festivals = Festival.all
  	end
    render json: {festivals: @festivals}
  end
end