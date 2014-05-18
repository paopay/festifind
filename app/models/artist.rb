class Artist < ActiveRecord::Base
	# include Rdio
 	has_and_belongs_to_many :festivals
end