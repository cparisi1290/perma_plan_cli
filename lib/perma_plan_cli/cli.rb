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
        puts Rainbow("              " + tractor + "       "    "Your list is coming up...").palevioletred
        
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
            puts Rainbow("\n#{index}. #{book.title}\n").mediumpurple
            puts Rainbow("By: #{book.author}").mediumpurple
            puts Rainbow("Price: #{book.price}").mediumpurple
        end
    end

    def get_book_method
        puts Rainbow("\nPlease select a number to find out more information about the book or type 'exit' to quit.\n").deepskyblue
        input = gets.strip
        until input.to_i.between?(0, list_books.length) || input == "exit"
            puts Rainbow("\nSorry! I don't understand that command.\n").deepskyblue
            input gets.strip
        end
                
        if input != "exit" 
            index = input.to_i - 1
            book = @sorted_books[index]
            puts Rainbow("\n#{book.title}").palevioletred
            puts Rainbow("by: #{book.author}").palevioletred
            puts Rainbow("price: #{book.price}").palevioletred
            want_more_info(book)     
        else 
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

    def want_more_info(book_object)
        puts Rainbow("\nRead more? (Y/N)\n").deepskyblue
        input = gets.strip.upcase
        until ["Y", "N", "YES", "NO"].include?(input)
            puts Rainbow("Please type Y or N to continue.").deepskyblue
            input = gets.strip.upcase
            puts Rainbow("Type Y/N to continue.").deepskyblue
        end
        if input == "Y" || input == "YES"
            puts Rainbow("\n...Fetching more info...\n").deepskyblue
            PermaPlanCli::Scraper.scrape_details(book_object)
            puts Rainbow("#{book_object.title}").mediumpurple
            puts Rainbow("by:#{book_object.author}\n").mediumpurple
            puts Rainbow("#{book_object.description}\n").mediumpurple
            get_book_method  
        else
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
end