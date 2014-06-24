class AdminController < ApplicationController
  def generate
    #get request tokens
    rdio = Rdio.new(["5xw5hwkpeerqpmcbwmgswaya", "qfy65r6Zrw"])
    callback_url = (URI.join request.url, admin_auth_path).to_s
    url = rdio.begin_authentication(callback_url)
    # save our request token in the session
    session[:rt] = rdio.token[0]
    session[:rts] = rdio.token[1]
    # go to Rdio to authenticate the app
    redirect_to url
  end

  def auth
    # get the state from cookies and the query string
    request_token = session[:rt]
    request_token_secret = session[:rts]
    verifier = params[:oauth_verifier]
    # make sure we have everything we need
    if request_token and request_token_secret and verifier
      # exchange the verifier and request token for an access token
      rdio = Rdio.new(["5xw5hwkpeerqpmcbwmgswaya", "qfy65r6Zrw"],
                      [request_token, request_token_secret])
      rdio.complete_authentication(verifier)
      # save the access token in cookies (and discard the request token)
      session[:at] = rdio.token[0]
      session[:ats] = rdio.token[1]
      session.delete(:rt)
      session.delete(:rts)
      # go to the home page
      redirect_to admin_playlists_path
    end
  end

  def playlists
    access_token = session[:at]

    access_token_secret = session[:ats]
    if access_token and access_token_secret
      rdio = Rdio.new(["5xw5hwkpeerqpmcbwmgswaya", "qfy65r6Zrw"],[access_token, access_token_secret])
      currentUser = rdio.call('currentUser')['result']
    end
    playlists = rdio.call('getUserPlaylists', {"user" => 's21182955',"count" => 240});
    Festival.all.each do |festival|
      playlists["result"].each do |playlist|      
       if playlist["name"] == festival.display_name
         festival.update_attributes({:playlist_url => playlist["embedUrl"], :icon => playlist["icon"]})
         festival.save
       end
      end
      if festival.playlist_url == nil
        name = festival.display_name
        desc = festival.city_name
        tracks = []

        festival.artists.each do |artist|
          new_tracks, top_track_id = Echonest.get_tracks_list(artist.song_kick_id.to_s)
          tracks << new_tracks
          artist.update_attribute(:top_track, top_track_id)
        end

        tracks = tracks.join(",")
        playlists = rdio.call('createPlaylist', {"name" => name, "description" => desc, "tracks" => tracks})
        festival.update_attributes({:playlist_url => playlists["result"]["embedUrl"], :icon => playlists["result"]["icon"]})
        festival.save
      end 
    end

    

    redirect_to root_path
  end
end