#This class creates and keeps track of movie objects so as not to repeatedly call the API for a
#previously called movie but will also keep a separate list for movies that the user has bookmarked

class Movie

    #Collections for all movie objects created and movies that the user bookmarks
    @@all = []
    @@bookmarks = []

    def initialize(hash)
        hash.each do |key, value|
            self.class.attr_accessor(key.downcase)
            self.send(("#{key.downcase}="), value)
        end

        @@all << self
    end

    #Show get an array of the users movie history
    def self.all 
        @@all
    end

    #Get the array of the users bookmarks
    def self.bookmarks
        @@bookmarks
    end

    def self.add_bookmark
        @@bookmarks << self
    end

    def self.delete_bookmark(title)
        bool = false
        mov = @@bookmarks.find {|movie| movie.title == title}
        @@bookmarks.delete(mov)
    
    end

    def get_ratings
        string = ""
        array = self.ratings
        array.each do |hash|
            string += "#{hash["Source"]}: #{hash["Value"]}\n"
        end
        string
    end


end
