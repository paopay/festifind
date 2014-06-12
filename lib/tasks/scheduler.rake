desc "This task is called by the Heroku scheduler add-on"

task :add_fests => :environment do
  puts "Adds new festivals..."
  Songkick.fetch_festival_ids
  puts "done."
end
