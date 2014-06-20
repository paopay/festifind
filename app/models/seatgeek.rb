class Seatgeek
	def self.get_top_link(display_name)
		display_name.gsub!(' ','%20')
		url = "http://api.seatgeek.com/2/events?q=#{display_name}&sort=score.desc"
		response = HTTParty.get(url)
		if response["events"].count > 0 
			link = response["events"][0]["performers"][0]["url"] + "/?aid=10853"
		else 
			link = "http://seatgeek.com/search?search={{display_name}}"
		end
		return link 
	end
end