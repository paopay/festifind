class Festival < ActiveRecord::Base
	validates_uniqueness_of :song_kick_id
 	has_many :artists, through: :artists_festivals
 	has_many :artists_festivals
 	def self.images

 		"hello"

 	end




end
