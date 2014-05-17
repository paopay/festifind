class Festival < ActiveRecord::Base
	attr_accessible :song_kick_id, :display_name,
    :start_date, :end_date, :city_name, :lat, :lng,
    :popularity, :url

	validates_uniqueness_of :song_kick_id

 	has_many :festival_artists
 	has_many :artists, through: :festival_artists
end
