class ArtistsController < ApplicationController

	def find
		greg = Festival.where(["display_name = ?", params[:festival]])
	 	render json: { artists: greg.first.artists }
	end

	def create
		Artist.create(artist_params)
	end

	def search
		results = []
		artist_match = Artist.kinda_matching params[:artist]
		artist_match.each_with_index do |artist, index|
			results[index] = artist.display_name, artist.festivals
		end
		render :json => {results: results}
	end

	private
	def artist_params
		params.require(:artist).permit(:song_kick_id, :display_name)
	end

	def index
		p "cool"
	end
end