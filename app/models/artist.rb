class Artist < ActiveRecord::Base
 	has_many :artists_festivals
	has_many :festivals, through: :artists_festivals
	include PgSearch
  	pg_search_scope :kinda_matching,
  					:against => :display_name,
                  	:using => {
                    	:tsearch => {:dictionary => "english"}
                  	}

end