class AddSeatgeekUrlToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :seatgeek_url, :string
  end
end