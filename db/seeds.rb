Songkick.fetch_festival_ids
Songkick.grab_favorites
# Songkick.get_images
def make_festivals(json_response)
	event = json_response["resultsPage"]["results"]["event"]
	_festival = Festival.create(song_kick_id: event["id"],
									popularity: event["popularity"],
									display_name: event["displayName"],
									start_date: event["start"]["date"],
									end_date: event["end"]["date"],
									lat: event["location"]["lat"],
									lng: event["location"]["lng"],
									city_name: event["location"]["city"],
									url: event["uri"],
									fest_icon: "http://www2.sk-static.com/images/media/profile_images/events/#{event["id"]}/col4")

	p event["performance"]
	url = Seatgeek.get_top_link(_festival.display_name)
	_festival.update_attributes({:ticket_url => url})
  _festival.save
 	seatgeek_id = ENV['SEATGEEK_APP_KEY']
	event["performance"].each do |artist|
		seatgeek = 'https://seatgeek.com/'+ artist["displayName"].gsub(' ','-') + '-tickets/?aid=#{seatgeek_id}'
		_festival.artists.create(song_kick_id: artist["artist"]["id"], display_name: artist["displayName"], seatgeek_url: seatgeek)
	end
end

module Songkick

	require 'net/http'
	require 'nokogiri'
	require 'json'


	def self.pull_id(listing)
	  /id\/(\d+)/.match(listing).to_a.last.to_i
	end

	def self.fetch_festival_ids
		num_of_pages = 2
		master_array = []
		(1..num_of_pages).each do |page_listings|
		  p = Page.new("http://www.songkick.com/search?page=#{page_listings}&per_page=10&query=festival&type=upcoming")
		  p.fetch!
		  master_array.concat(p.links)
		end
		json_array = master_array.map do |id|
			Songkick.fetch_festival_info(id)
		end
		json_array
	end

	def self.fetch_festival_info(id)
		songkick_key = ENV['SONGKICK_API_KEY']
		query_url = URI("http://api.songkick.com/api/3.0/events/#{id}.json?apikey=#{songkick_key}")
		json_response = Net::HTTP.get(query_url)
		make_festivals(JSON.parse(json_response))
	end


	class Page
	  attr_reader :url, :data  # <- REMOVE
	  def initialize(url)
	    @url = URI(url)
	  end

	  def fetch!
	    raw_data = Net::HTTP.get(@url)
	    @data = Nokogiri::HTML(raw_data)
	  end

	  def links
	    return_array = []
	    @data.css('a').each do |l|
	      listing = l['href']
	      if listing
	        return_array << Songkick.pull_id(listing) if listing.start_with?("/festivals")
	      end
	    end
	    return_array.uniq
	  end
	end
end
