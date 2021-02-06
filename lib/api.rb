#This class is responsible for grabbing the data for a given movie


class API

    attr_accessor :title, :url 

    #Hides the API key
    # APIKEY = ENV["API_KEY"]

    #Constant to hold majority of the url
    URL = "http://www.omdbapi.com/?i=tt3896198&apikey=#{ENV["API_KEY"]}&t="

    #API instantiated with a movie title that gets appended to the URL constant
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
