desc "This task is called by the Heroku scheduler add-on"

task :add_fests => :environment do
  puts "Adds new festivals..."
  Songkick.fetch_festival_ids
  puts "done."
end

task :create_new_playlists => :environment do
  visit 'admin/generate'
  click 'Allow'
end