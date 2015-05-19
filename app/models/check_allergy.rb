require 'rest-client'
require 'json'
require 'pry'


class CheckAllergy < ActiveRecord::Base

def findAllergy

request = RestClient::Request.new(
    method: :post,
    url: 'https://api.unify.manahealth.com/api/login',
    user: 'mana',
    password: 'm@n@H3@lth',
    verify_ssl: false,
    headers: {accept: :json},
    payload: {user: 'test4', pwd: 'test1234'}
    ).execute

response = RestClient.post(endpoint_url)




end
