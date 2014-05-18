class CreateFestivalArtists < ActiveRecord::Migration
  def change
    create_join_table :festivals, :artists 
  end
end
