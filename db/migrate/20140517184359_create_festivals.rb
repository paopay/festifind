class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
    	t.integer :song_kick_id
    	t.string :display_name
    	t.datetime :start_date
    	t.datetime :end_date
    	t.string :city_name
    	t.float :lat
    	t.float :lng
    	t.float	:popularity
    	t.string :url
        t.string :playlist_url
        t.string :icon
    	t.timestamps
    end
  end
end
