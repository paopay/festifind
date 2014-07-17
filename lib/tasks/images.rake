require 'HTTParty'
task :greet => :environment do
	  Google.start_search_for_images
end


module Google
	def self.start_search_for_images
		Festival.all.each do |festival|
				festival_image= Google.get_json_from_google(festival.display_name)
			festival.update_attribute(:fest_icon, "festival_image")
			festival.save
		end
	end

	def self.get_json_from_google(display_name)
		display_name	= display_name.downcase.tr!(" ", "_")
		response = HTTParty.get("https://www.googleapis.com/customsearch/v1?key=AIzaSyA8K33aJWJrBP23XfrVn34HYg2fG4Js1AI&cx=001913588589495655496:k2ycnxpl5ye&q=#{display_name}+lineup+poster&searchType=image&alt=json&limit=1")
		p response
		response["items"][0]["link"]

	end


end




# def self.get_images
# 				Festival.all.each do |festival|
# 				
				
# 		require "awesome_print"
# 		queryurl = get("https://www.googleapis.com/customsearch/v1?key=AIzaSyA8K33aJWJrBP23XfrVn34HYg2fG4Js1AI&cx=001913588589495655496:k2ycnxpl5ye&q=#{festival_name}&searchType=image&imgSize=large&alt=json&limit=1")
# 		# greg = Net::HTTP.get(queryurl)
# 		
# 		# image_url = JSON.parse(greg) 
# 		byebug
# 		# ap response
# 				end
# 	end