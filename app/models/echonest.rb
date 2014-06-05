class Echonest

  ECHONEST_API_KEY = "JWVN3A7TD59W9C53I"

  def self.get_track_json(songkick_artist_id)
    query_url = "http://developer.echonest.com/api/v4/playlist/static?api_key=" + ECHONEST_API_KEY + "&artist_id=songkick:artist:" + songkick_artist_id.to_s + "&sort=song_hotttnesss-desc&results=3&type=artist&bucket=tracks&bucket=id:rdio-US&limit=true"
    query_response = HTTParty.get(query_url).body
    return MultiJson.load(query_response)
  end

  def self.get_tracks_list(songkick_artist_id)
    tracks = Array.new
    top_track = ''
    json = self.get_track_json(songkick_artist_id)
    # puts "ke" * 30
    # puts json
    # puts "ke" * 30
    track_list = json["response"]["songs"]

    unless track_list == nil || track_list.empty?
    	top_track = track_list.first["title"]
      for track in track_list
        rdio_id = track["tracks"].first["foreign_id"].gsub(/rdio\-US:track:/, "")
        tracks << rdio_id
      end
    end
    return tracks, top_track
  end

  def self.get_song_title(song_id)
    query_url = "http://developer.echonest.com/api/v4/song/static?api_key=" + ECHONEST_API_KEY + "&id=#{song_id}"
    query_response = HTTParty.get(query_url).body
    # return JSON.parse(query_response).to_hash
  end
end
