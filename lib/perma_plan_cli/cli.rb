class PermaPlanCli::CLI
    attr_accessor :sorted_books

    def call
        tractor = "\u{1F69C}"
        puts Rainbow("\nWelcome to the Perma-Planning Resource App!\n").deepskyblue
        sleep(1)
        puts Rainbow("\nHere are your choice of permaculture books to start on your homestead!").deepskyblue
        sleep(1)
        puts "                                   " + tractor
        sleep(1)
        puts "                               " + tractor
        sleep(1)
        puts Rainbow("                           " + tractor + "     "+"Stuck behind a tractor...").palevioletred
        sleep(1)
        puts "                       " + tractor
        sleep(1)
        puts "                   " + tractor
        sleep(1)
        puts Rainbow("               " + tractor + "       "+"Your list is coming up...").palevioletred
        
        PermaPlanCli::Scraper.scrape_books
        sort_books
        list_books
        get_book_method
    end

    def sort_books        
        @sorted_books = PermaPlanCli::Book.all.sort_by {|book| book.title}  
    end

    def list_books
        @sorted_books.each.with_index(1) do |book, index|
            puts Rainbow("\n#{index}. #{book.title}").mediumpurple
            puts Rainbow("    by: #{book.author}").mediumpurple
            puts Rainbow("    price: #{book.price}").mediumpurple
        end
    end

    def get_book_method
        puts Rainbow("\nPlease select a number to find out more information about the book or type 'exit' to quit.\n").deepskyblue
        input = gets.strip
        until input.to_i.between?(0, list_books.length) || input == "exit"
            puts Rainbow("\nSorry! I don't understand that command.").deepskyblue 
            puts Rainbow("Please select a valid number or type exit to quit.\n").deepskyblue
            input = gets.strip
        end
               
        if input.to_i != 0
            index = input.to_i - 1
            book = @sorted_books[index]
            puts Rainbow("\n#{book.title}").palevioletred
            puts Rainbow("by: #{book.author}").palevioletred
            puts Rainbow("price: #{book.price}").palevioletred
            want_more_info(book)
        elsif input == "exit"
            self.exit  
        else 
            get_book_method
        end
    end

    def want_more_info(book_object)
        puts Rainbow("\n Type 'YES' for more information - Type 'list' to see the selection of books again - Type 'exit' to quit..\n").deepskyblue
        input = gets.strip.upcase
        until ["Y", "YES", "list", "LIST", "EXIT", "exit"].include?(input)
            puts Rainbow("Please type 'YES' or 'list' to continue - Type 'exit' to quit.").deepskyblue
            input = gets.strip.upcase
        end
        
        if input == "Y" || input == "YES"
            puts Rainbow("\n...Fetching more info...\n").deepskyblue
            PermaPlanCli::Scraper.scrape_details(book_object)
            puts Rainbow("#{book_object.title}").mediumpurple
            puts Rainbow("by:#{book_object.author}\n").mediumpurple
            puts Rainbow("#{book_object.description}\n").mediumpurple
            show_book_list_again      
        elsif input == "LIST"
            list_books
            get_book_method
        else input == "EXIT"
            self.exit
        end
    end

    def show_book_list_again
        puts Rainbow("Type 'list' to see the selection of books again - Type 'exit' to quit.\n").deepskyblue
        show_book_list_again_input = gets.strip.upcase
        until ["list", "LIST", "EXIT", "exit"].include?(show_book_list_again_input)
            puts Rainbow("Please type 'list' to continue - Type 'exit' to quit.").deepskyblue
            show_book_list_again_input = gets.strip.upcase
        end
        if show_book_list_again_input == "LIST"
            list_books
            get_book_method
        elsif show_book_list_again_input == "EXIT"
            self.exit
        end
    end

    def exit
        puts ""
            puts Rainbow("\nSee you on the homestead!\n").deepskyblue
            puts ""
            puts <<-'EOF'
                       '
            .      '      .
      .      .     :     .      .
       '.        ______       .'
         '  _.-"`      `"-._ '
          .'                '.
   `'--. /                    \ .--'`
        /                      \
       ;                        ;
  - -- |                        | -- -
       |     _.                 |
       ;    /__`A   ,_          ;
   .-'  \   |= |;._.}{__       /  '-.
      _.-""-|.' # '. `  `.-"{}<._
            / 1990  \     \  x   `"
       ----/         \_.-'|--X----
       -=_ |         |    |- X.  =_
      - __ |_________|_.-'|_X-X##
      ... `'-._|_|;:;_.-'` '::.  `"-
       .:;.      .:.   ::.     '::."
       EOF
    end
end