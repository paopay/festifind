class Artist < ActiveRecord::Base
 	has_many :festival_artists
 	has_many :festivals, through: :festival_artists
end