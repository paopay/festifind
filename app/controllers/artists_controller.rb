class ArtistsController < ApplicationController

	def create
		Artist.create(artist_params)
	end


	private

	def artist_params
		params.require(:artist).permit(:song_kick_id, :display_name)
	end
end