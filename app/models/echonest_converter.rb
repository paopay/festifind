class EchonestConverter

  def initialize(api_key)
    @api_key = api_key
    @base_uri = "http://developer.echonest.com/api/v4/artist/profile?api_key"
  end

  def convert_songkick_to_echonest(songkick_arr)
    songkick_arr.map do |songkick_id|
      response_body = HTTParty.get("#{@base_uri}=#{@api_key}&id=songkick:artist:#{songkick_id}").body
      response_body_obj = JSON.parse(response_body)
      response_body_obj["response"]["artist"]["id"]
    end
  end
  
end