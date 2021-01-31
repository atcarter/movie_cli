#This class is responsible for grabbing the data for a given movie

require 'net/http'
require 'open-uri'
require 'json'
# require_relative '../lib/movie.rb'

class API
    attr_accessor :title, :url 

    #Constant to hold majority of the url
    URL = "http://www.omdbapi.com/?i=tt3896198&apikey=6eb6e1aa&t="

    #API instantiated with a title that gets appended to the URL constant
    def initialize(title)
        @title = title
        @url = URL + title
    end

    def get_response
        uri = URI.parse(self.url)
        response = Net::HTTP.get_response(uri)
        response.body
    end

    
    def parse_json
        JSON.parse(self.get_response)
    end


end

# api = API.new("the matrix")
# mov = Movie.new(api.parse_json)
# puts mov.get_ratings