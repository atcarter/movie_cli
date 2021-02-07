#This class handles the input and output of the Movie CLI app
class CLI

    # def initialize
    # end

    def call

        input = ""
        puts "\nWelcome to the Movie CLI Application!"

        while input != "quit_app"
            puts "\n\nPlease enter the title of the movie you are searching for or open \'My Bookmarks\' [b]. [quit_app] to quit.\n\n"

            input = gets.strip
            
            if input == "quit_app"
                return

            elsif input == "b"
                display_bookmarks

                edit = ""
                while edit != "done" && Movie.bookmarks.count > 0
                    puts "\nTo delete a movie, type the title (exactly as it is). When finished, type \'done\'."
                    edit = gets.strip
                    Movie.delete_bookmark(edit)
                    puts ""
                    display_bookmarks
                end
        
            else
                if display_movie(input) == false
                    puts "\nMovie not found!"
                    puts "_____________________________________________"
                else          
                    input2 = ""
                    while input2 != "n" || input2 != "y"
                        puts "\nWould you like to see the ratings for #{Movie.current_movie.title} [r] or add #{Movie.current_movie.title} to My Bookmarks? [y] or [n]"
                        input2 = gets.strip

                        case input2
                        when "r"
                        #iterates over the ratings hash to output however many sources/ratings there are for a given movie
                            display_ratings
                        when "y"
                            Movie.add_bookmark
                            break
                        when "n"
                            break
                        end
                    end
                end
            end           
        end      
    end

    #This method displays the initial movie information before the user decides to see the movie ratings or not
    def display_movie(title)
        movie = Movie.find_or_create_movie(title)
        if movie == "Movie not found!"
            false
        else
            puts "___________________________________"
            puts "\n#{movie.title} (#{movie.year})\n\n"
            puts "Directed by: #{movie.director}"
            puts "Starring: #{movie.actors}"
            puts "#{movie.plot}\n\n"
        end
    end

    def display_ratings
        puts "\n#{Movie.current_movie.get_ratings}\n"
    end

    #This method allows a user to see all of the movies in their bookmarks as well as their ratings. 
    def display_bookmarks
        puts "     My Bookmarks    "
        puts "______________________\n\n"
        if Movie.bookmarks.count == 0
            puts "My Bookmarks are empty."
        else
            Movie.bookmarks.each do |movie|
                puts "#{movie.title} (#{movie.year})"
                puts "\n#{movie.get_ratings}"
                puts "___________________________________"
            end
        end
    end

end
