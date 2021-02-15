#This class creates and keeps track of movie objects so as not to repeatedly call the API for a
#previously called movie but will also keep a separate list for movies that the user has bookmarked

class Movie

    #Collections for all movie objects created and movies that the user bookmarks
    #Class variable to track the current movie 

    @@all = []
    @@bookmarks = []
    @@current_movie

    def initialize(hash)
        hash.each do |key, value|
            self.class.attr_accessor(key.downcase)
            self.send(("#{key.downcase}="), value)
        end
        self.class.all << self
        self.class.current_movie = self
    end

    #Show get an array of the users movie history
    def self.all
        @@all
    end

    #Get the array of the users bookmarks
    def self.bookmarks
        @@bookmarks
    end

    #Add unique movies to My Bookmarks
    def self.add_bookmark
        @@bookmarks << @@current_movie unless @@bookmarks.find{|mov| mov.title == @@current_movie.title }
    end

    def self.current_movie
        @@current_movie
    end

    def self.current_movie=(movie)
        @@current_movie = movie
    end

    #returns true if the movie is removed from the collection of bookmarks and false if it didnt exist
    def self.delete_bookmark(title) 
        #title = title.capitalize unless title.capitalize == nil don't think this is necessary
        bool = false
        mov = @@bookmarks.find {|movie| movie.title == title}
        if mov != nil
            @@bookmarks.delete(mov)
            bool = true
        end
        bool    
    end

    #return a string of all the ratings that a movie has
    def get_ratings
        string = ""
        array = self.ratings
        array.each do |hash|
            string += "#{hash["Source"]}: #{hash["Value"]}\n"
        end
        string
    end

    def self.find_or_create_movie(title)
        self.all.find do |mov|
            return mov if mov.title.downcase == title
        end
            
        api = API.new(title)
        if api.parse_json == {"Response" => "False", "Error" => "Movie not found!"}
            "Movie not found!"
        else
            Movie.new(api.parse_json)
        end            
    end

    # create a method that returns an alphebitized list of bookmarked movies 
    # def self.alphabetizeBookmarks
    #      @@bookmarks.sort_by do |b|
    #         b.title
    #      end.each  do |bookmark|
    #         puts "#{bookmark}"

    #      end 
    # end



end
