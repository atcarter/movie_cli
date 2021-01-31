#This class handles the input and output of the Movie CLI app
class CLI

    # def initialize
    # end

    def call

        input = ""
        puts "\nWelcome to the Movie CLI Application!"

        while input != "quit_app"
            puts "\n\nPlease enter the title of the movie you are searching for or open \'My Bookmarks\' [b]. \'quit_app\' to quit.\n\n"

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
                end
        
            else
                if display_movie(input) == false
                    puts "\nMovie not found!"
                    puts "_____________________________________________"
                else
                    puts "\nWould you like to add #{Movie.current_movie.title} to My Bookmarks? \'y\' or \'n\'"
                    input2 = gets.strip

                    case input2
                    when "y"
                    # puts "the value is : #{Movie.current_movie}"
                        Movie.add_bookmark
                    when "n"

                    end
                end
            end           
        end      
    end

    def display_movie(title)
        movie = Movie.find_or_create_movie(title)
        if movie == "Movie not found!"
            false
        else
            # Movie.current_movie = Movie.all[0]#movie
            puts "#{movie.title} (#{movie.year})"
            puts "#{movie.get_ratings}\n"
            puts "#{movie.plot}\n\n"
            puts "Directed by: #{movie.director}"
            puts "Starring: #{movie.actors}"
        end
    end

    def display_bookmarks
        puts "     My Bookmarks    "
        puts "______________________\n\n"
        if Movie.bookmarks.count == 0
            puts "My Bookmarks are empty."
        else
            Movie.bookmarks.each do |movie|
                puts "#{movie.title} (#{movie.year})"
                puts "#{movie.get_ratings}"
                puts "___________________________________"
            end
        end
    end

end
