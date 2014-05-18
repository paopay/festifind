class FestivalsController < ApplicationController
  def index
  	@festivals = Festival.all
    render json: {festivals: @festivals}
  end

  def create
  	Festival.create(festival_params)
  end



  private

  def festival_params
  	params.require(:festival).permit(:song_kick_id, :display_name,
    :start_date, :end_date, :city_name, :lat, :lng,
    :popularity, :url)
  end
end