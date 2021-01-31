#This class handles the input and output of the Movie CLI app
class CLI

    def initialize
    end

    def call

        input = ""
        puts "Welcome to the Movie CLI Application!"

        while input != "quit"
            puts "Please enter the title of the movie you are searching for or open \'My Bookmarks\' [b]"

            input = gets.strip
            if input == "b"
                display_bookmarks
            else
                display_movie(input)
                puts "Would you like to add #{Movie.current_movie.title} to My Bookmarks? \'y\' or \'n\'"
                input2 = gets.strip

                case input
                when "y"
                    Movie.add_bookmark
                when "n"
                end
            end           

        end



    
    
    
    
    end

    def display_movie(title)
        movie = API.find_or_create_movie(title)
        if movie == "Movie not found!"
            puts movie
        else
            Movie.current_movie = movie
            puts "#{movie.title} (#{movie.year})"
            puts "#{movie.get_ratings}"
            puts "#{movie.plot}"
            puts "Directed by: #{movie.director}"
            puts "Starring: #{movie.actors}"
        end
    end

    def display_bookmarks
        puts "     My Bookmarks    "
        puts "______________________"
        if Movie.bookmarks.count == 0
            "My Bookmarks are empty."
        else
            Movie.bookmarks.each do |movie|
                puts "#{movie.title} (#{movie.year})"
                puts "#{movie.get_ratings}"
                puts "___________________________________"
            end
        end
    end

end
