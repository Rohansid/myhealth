require 'base64'
require 'rest-client'
require 'pry'

class ManaCloud
  class UserNotAuthenticated < StandardError; end

  ENDPOINT_URL = 'https://sandbox.manahealth.com/api'
  BASIC_AUTH = {
    username: 'mana',
    password: 'm@n@H3@lth'
  }

  # Initialize the class with a username and password. The user must specify
  # this.
  def initialize(user, password)
    @user = user
    @password = password

    # In the constructor, try to authenticate and get the access_token and
    # client_id
    authenticate
  end

  # A method that POSTs out to the login endpoint and stores the access_token
  # and client_id from the response in instance variables that the class can
  # continue to use in subsequent requests
  def authenticate
    response = post('login')
    @access_token = response['access-token']
    @client_id = response['client-id']
  end

  # Method to return the allergies endpoint
  def allergies
    raise UserNotAuthenticated unless access_token

    get('records/allergies')
  end

  # Method to return the allergies endpoint
  def vitals
    raise UserNotAuthenticated unless access_token

    get('records/vitals')
  end

  private

  attr_reader :client_id, :access_token, :user, :password

  # A low level (private) method that allows us to send POST requests to the
  # ManaCloud servers. This uses the specific implementation of Basic Auth and
  # a user and password payload (as json) outside the context of params.
  def post(url)
    response = RestClient::Request.new(
      method: :post,
      url: "#{ENDPOINT_URL}/#{url}",
      verify_ssl: false,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Basic #{authorization_hash}"
      },
      payload: {user: user, pwd: password}.to_json
    ).execute

    # Parse the response to Ruby objects
    JSON.parse(response)
  end

  # A low level (private) method that allows us to send GET requests to the
  # ManaCloud servers. This uses the specific implementation of Basic Auth and
  # the access_token and client_id outside the context of params.
  def get(url, opts = {})
    response = RestClient::Request.new(
      method: :get,
      url: "#{ENDPOINT_URL}/#{url}",
      verify_ssl: false,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Basic #{authorization_hash}",
        'client-id' => client_id,
        'access-token' => access_token
      },
      payload: opts
    ).execute

    JSON.parse(response)
  end

  # A method to Base64 encode the basic auth username and password in the
  # the following format:
  #   username:password
  def authorization_hash
    Base64.encode64("#{BASIC_AUTH.fetch(:username)}:#{BASIC_AUTH.fetch(:password)}").strip
  end
end

### Sample code, this will vary from implementation to implementation

