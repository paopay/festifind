class FestivalsController < ApplicationController

  def index
  	@festivals = Festival.all
    @festivals.to_a.sort_by! do |festival|
      festival.start_date
    end
  end
  def show
    @festival = Festival.find params[:id]
    @artists = @festival.artists
  end

  def create
  	Festival.create(festival_params)
  end

  def sort
    festivals = Festival.all
    festivals.to_a.sort_by! do |festival|
      festival.start_date
    end
    render :json => {:result => festivals}
  end

  # # Although hacky, you would just call the login route manually,
  # # to create playlists
  def playlists
    access_token = session[:at]
    access_token_secret = session[:ats]
    if access_token and access_token_secret
      rdio = Rdio.new(["5xw5hwkpeerqpmcbwmgswaya", "qfy65r6Zrw"],[access_token, access_token_secret])
      currentUser = rdio.call('currentUser')['result']
      Festival.all.each do |festival|
        name = festival.display_name
        desc = festival.city_name
        tracks = []
        p festival.display_name
        p "*" * 50
        festival.artists.each do |artist|
          p artist
          tracks << festival.get_tracks_list(artist.song_kick_id.to_s)
          artist.update_attribute(:top_track, tracks.first.first)
        end
        tracks = tracks.join(",")
        playlists = rdio.call('createPlaylist', {"name" => name, "description" => desc, "tracks" => tracks})
        festival.update_attributes({:playlist_url => playlists["result"]["embedUrl"], :icon => playlists["result"]["icon"]})
        festival.save
      end
      tracks = []
      playlists = rdio.call('createPlaylist', {"name" => name, "description" => desc, "tracks" => "t45423856, t45423856"})
    end
  end

  def login
    #get request tokens
    rdio = Rdio.new(["5xw5hwkpeerqpmcbwmgswaya", "qfy65r6Zrw"])
    callback_url = (URI.join request.url, festivals_auth_path).to_s
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
      redirect_to festivals_playlists_path
    end
  end

  private
  def festival_params
  	params.require(:festival).permit(:song_kick_id, :display_name,
    :start_date, :end_date, :city_name, :lat, :lng,
    :popularity, :url, :playlist_url, :icon, :fest_icon)
  end

  require 'om'
  require 'uri'
  require 'net/http'
  require 'cgi'
  require 'json'

  class Rdio
    # the consumer and token can be accessed
    attr_accessor :consumer, :token

    def initialize(consumer, token=nil)
      @consumer = consumer
      @token = token
    end

    def begin_authentication(callback_url)
      # request a request token from the server
      response = signed_post('http://api.rdio.com/oauth/request_token',
                             {'oauth_callback' => callback_url})
      # parse the response
      parsed = CGI.parse(response)
      # save the token
      @token = [parsed['oauth_token'][0], parsed['oauth_token_secret'][0]]
      # return an URL that the user can use to authorize this application
      return parsed['login_url'][0] + '?oauth_token=' + parsed['oauth_token'][0]
    end

    def complete_authentication(verifier)
      # request an access token
      response = signed_post('http://api.rdio.com/oauth/access_token',
                             {'oauth_verifier' => verifier})
      # parse the response
      parsed = CGI.parse(response)
      # save the token
      @token = [parsed['oauth_token'][0], parsed['oauth_token_secret'][0]]
    end

    def call(method, params={})
      # make a copy of the dict
      params = params.clone
      # put the method in the dict
      params['method'] = method
      # call to the server and parse the response
      p params
      return JSON.load(signed_post('http://api.rdio.com/1/', params))
    end

  private

    def signed_post(url, params)
      auth = om(@consumer, url, params, @token)
      url = URI.parse(url)
      http = Net::HTTP.new(url.host, url.port)
      req = Net::HTTP::Post.new(url.path, {'Authorization' => auth})
      req.set_form_data(params)
      res = http.request(req)
      return res.body
    end

    def method_missing(method, *params)
      call(method.to_s, params[0])
    end

  end
end