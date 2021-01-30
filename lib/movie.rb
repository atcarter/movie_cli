#This class creates and keeps track of movie objects so as not to repeatedly call the API for a
#previously called movie but will also keep a separate list for movies that the user has bookmarked

class Movie

    def initialize(hash)
        hash.each do |key, value|
            self.class.attr_accessor(key.downcase)
            self.send(("#{key.downcase}="), value)
        end
    end


end
