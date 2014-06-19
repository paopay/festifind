class Artist < ActiveRecord::Base
	include PgSearch
  	pg_search_scope :search_by_name,
                  	:against => :display_name
 	has_and_belongs_to_many :festivals
end