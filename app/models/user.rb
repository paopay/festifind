class User < ActiveRecord::Base
include BCrypt
has_secure_password
  validates :password, :presence => { :on => :create }
end 
