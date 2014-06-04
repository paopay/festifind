require 'spec_helper'

feature 'on the homepage' do
	scenario 'click explore festival brings up new page', js: true do
		visit root_path
		click_on 'Explore festival'
	end
end