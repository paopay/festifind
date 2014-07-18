class Comment < ActiveRecord::Base

	belongs_to :festival
	belongs_to :user

end