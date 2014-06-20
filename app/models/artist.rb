class Artist < ActiveRecord::Base
	include PgSearch
  	pg_search_scope :kinda_matching,
  					:against => :display_name,
                  	:using => {
                    	:tsearch => {:dictionary => "english"}
                  	}
 	has_and_belongs_to_many :festivals
end