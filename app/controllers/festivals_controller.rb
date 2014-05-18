class FestivalsController < ApplicationController

  require 'httparty'
  require 'multi_json'

  API_KEY = "JWVN3A7TD59W9C53I"

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

  def get_track_json(songkick_artist_id)
    query_url = "http://developer.echonest.com/api/v4/playlist/static?api_key=" + API_KEY + "&artist_id=songkick:artist:" + songkick_artist_id + "&sort=song_hotttnesss-desc&results=3&type=artist&bucket=tracks&bucket=id:rdio-US&limit=true"

    query_response = HTTParty.get(query_url).body

    return MultiJson.load(query_response)
  end

  def get_tracks_list(songkick_artist_id)
    tracks = Array.new
    json = get_track_json(songkick_artist_id)

    for track in json["response"]["songs"]
      rdio_id = track["tracks"].first["foreign_id"]
      tracks << rdio_id.gsub(/rdio\-US:track:/, "")
    end

    return tracks
  end

end