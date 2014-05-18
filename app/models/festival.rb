class Festival < ActiveRecord::Base
	validates_uniqueness_of :song_kick_id

 	has_and_belongs_to_many :artists

  require 'httparty'
  require 'multi_json'

  API_KEY = "JWVN3A7TD59W9C53I"

  def get_track_json(songkick_artist_id)
    query_url = "http://developer.echonest.com/api/v4/playlist/static?api_key=" + API_KEY + "&artist_id=songkick:artist:" + songkick_artist_id + "&sort=song_hotttnesss-desc&results=3&type=artist&bucket=tracks&bucket=id:rdio-US&limit=true"
    puts query_url

    query_response = HTTParty.get(query_url).body

    return MultiJson.load(query_response)
  end

  def get_tracks_list(songkick_artist_id)
    tracks = Array.new
    json = get_track_json(songkick_artist_id)

    p json["response"]["songs"]
    p "hi" * 40
    if json["response"]["songs"] != nil
      for track in json["response"]["songs"]
        rdio_id = track["tracks"].first["foreign_id"]
        tracks << rdio_id.gsub(/rdio\-US:track:/, "")
      end
    end
    return tracks
  end
end
