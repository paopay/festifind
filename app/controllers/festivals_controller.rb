class FestivalsController < ApplicationController

  require 'rdio'

  def index
  	@festivals = Festival.all
    render json: {festivals: @festivals}
  end

  def create
  	Festival.create(festival_params)
  end

  # Although hacky, you would just fun the login route manually,
  # to create playlists
  def playlists
    access_token = session[:at]
    access_token_secret = session[:ats]
    if access_token and access_token_secret
      rdio = Rdio.new(["HPQlUKwWMb4fvkJkklCj_Q", "21IDJcJSIj9kqaZM2na_og"],[access_token, access_token_secret])
      currentUser = rdio.call('currentUser')['result']
      playlists = rdio.call('getPlaylists')['result']['owned']
      response = "
      <html><head><title>Rdio-Simple Example</title></head><body>
      <p>%s's playlists:</p>
      <ul>
      " % currentUser['firstName']
      playlists.each do |playlist|
        response += '<li><a href="%s">%s</a></li>' % [playlist['shortUrl'], playlist['name']]
      end
      response += '</ul><a href="/logout">Log out of Rdio</a></body></html>'
      return response
    else
      return '
      <html><head><title>Rdio-Simple Example</title></head><body>
      <a href="/login">Log into Rdio</a>
      </body></html>
      '
    end
  end

  def login
    #get request tokens
    rdio = Rdio.new(["HPQlUKwWMb4fvkJkklCj_Q", "21IDJcJSIj9kqaZM2na_og"])
    callback_url = (URI.join request.url, auth).to_s
    url = rdio.begin_authentication(callback_url)
    # save our request token in the session
    session[:rt] = rdio.token[0]
    session[:rts] = rdio.token[1]
    debugger
    # go to Rdio to authenticate the app
    redirect url
  end

  def auth
    # get the state from cookies and the query string
    request_token = session[:rt]
    request_token_secret = session[:rts]
    verifier = params[:oauth_verifier]
    # make sure we have everything we need
    if request_token and request_token_secret and verifier
      # exchange the verifier and request token for an access token
      rdio = Rdio.new(["HPQlUKwWMb4fvkJkklCj_Q", "21IDJcJSIj9kqaZM2na_og"], 
                      [request_token, request_token_secret])
      rdio.complete_authentication(verifier)
      # save the access token in cookies (and discard the request token)
      session[:at] = rdio.token[0]
      session[:ats] = rdio.token[1]
      session.delete(:rt)
      session.delete(:rts)
      # go to the home page
      redirect root_path
    end
  end



  private

  def festival_params
  	params.require(:festival).permit(:song_kick_id, :display_name,
    :start_date, :end_date, :city_name, :lat, :lng,
    :popularity, :url)
  end
end