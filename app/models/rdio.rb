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
