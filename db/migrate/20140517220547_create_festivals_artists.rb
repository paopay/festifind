class CreateFestivalsArtists < ActiveRecord::Migration
  def change
    create_table :festivals_artists do |t|
    	belongs_to :artists
    	belongs_to :festivals
    end
  end
end
