class ArtistsController < ApplicationController

	def find
		greg = Festival.where(["display_name = ?", params[:festival]])
	 	render json: { artists: greg.first.artists }
	end

	def create
		Artist.create(artist_params)
	end

	private
	def artist_params
		params.require(:artist).permit(:song_kick_id, :display_name)
	end

	def index
	end
	
end