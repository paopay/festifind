class FestivalsController < ApplicationController

  def index 
  end

  def show
    @festival = Festival.find params[:id]
    session[:festival_id] = @festival.id
    @artists = @festival.artists
    @vid_src = "http://www.youtube.com/embed/" + Youtube.get_video_id(@artists.first, @artists.first.top_track)
  end

  def videos
    artist = Artist.find params[:artist]
    @vid_src = "http://www.youtube.com/embed/" + Youtube.get_video_id(artist, artist.top_track)
    render :layout => false, :text => @vid_src 
  end

  def create
  	Festival.create(festival_params)
  end

  def sort
    festivals = Festival.order(:start_date)
    render :json => {:result => festivals}
  end

  def angular 
    @festival = Festival.find session[:festival_id]
    @artists = @festival.artists
    render :json => {:result => @artists}
  end

  private
  def festival_params
  	params.require(:festival).permit(:song_kick_id, :display_name,
    :start_date, :end_date, :city_name, :lat, :lng,
    :popularity, :url, :playlist_url, :icon, :fest_icon)
  end
end

