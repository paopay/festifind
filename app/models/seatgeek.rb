class Seatgeek
	def self.get_top_link(display_name)
		seatgeek_id = ENV['SEATGEEK_APP_KEY']
		sg_name = display_name.gsub(' ','%20')
		sg_name.gsub!('&','and')
		url = "http://api.seatgeek.com/2/events?q=#{sg_name}&sort=score.desc"
		response = HTTParty.get(url)
		ap response
		if response["meta"]["total"] > 0 
			link = response["events"][0]["performers"][0]["url"] + "/?aid=#{seatgeek_id}"
		else 
			link = "http://seatgeek.com/search?search=#{display_name}"
		end
		return link 
	end
end