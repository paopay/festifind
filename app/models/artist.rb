class Artist < ActiveRecord::Base
 	has_and_belongs_to_many :festivals
end