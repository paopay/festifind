API_KEY = "AIzaSyDoOC79rOwMlQ2HcBhMED9Oc2X7P99Gf7Q"

class Youtube

	def self.get_video(artist_name, song_name = '')
		artist_and_song_array = artist_name.split(' ') + song_name.split(' ')
		search_string = artist_and_song_array.join('+')
		url = "https://www.googleapis.com/youtube/v3/search?part=id%2Csnippet&type=video&videoEmbeddable=true&key=#{API_KEY}"
		response = HTTParty.get url
		response["items"].first["id"]["videoId"]
	end
end