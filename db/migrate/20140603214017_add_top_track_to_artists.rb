class AddTopTrackToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :top_track, :string
  end
end
