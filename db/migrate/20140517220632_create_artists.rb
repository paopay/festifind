class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
    	t.integer :song_kick_id
    	t.string  :display_name
    	t.timestamps
    end
  end
end
