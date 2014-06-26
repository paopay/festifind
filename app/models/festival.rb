class Festival < ActiveRecord::Base
	validates_uniqueness_of :song_kick_id
 	has_and_belongs_to_many :artists

 	def images

 		p "hello"

 	end




end
