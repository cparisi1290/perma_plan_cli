class PermaPlanCli::Scraper
    attr_accessor :url, :title, :author, :description, :detail

    BASE_URL = "https://bookshop.org"

    def self.scrape_books
        page = Nokogiri::HTML(open("#{BASE_URL}/books?keywords=permaculture"))

        array_of_books = page.css("div.booklist-book")
        
        # array_of_books.each do |book_square|

        #     if book_square.css("h2.font-serif-bold a")[0].attributes['href'].value != nil
        #         url = BASE_URL + book_square.css("h2.font-serif-bold a")[0].attributes['href'].value 
        #     else
        #         url = nil
        #     end

        #     title = book_square.css("h2.font-serif-bold").text.strip
        #     author = book_square.css("h3.text-s").text.strip
        #     price = book_square.css("div.pb-4 div.font-sans-bold").text.strip
        
        # book = PermaPlanCli::Book.new(title, author, price, url)

        # end

        array_of_books.map do |book_square|
            {
                title: book_square.css("h2.font-serif-bold").text.strip,
                author: book_square.css("h3.text-s").text.strip,
                price: book_square.css("div.pb-4 div.font-sans-bold").text.strip,
                url: BASE_URL + book_square.css("h2.font-serif-bold a")[0].attributes['href'].value
            }
        end
    end

    def self.scrape_details(book_object)

        details_page = Nokogiri::HTML(open(book_object.url))

        details_container = details_page.css(".measure")
        description = details_container.css("div.measure div div p").first.text.strip
        book_object.description = description
    end

end

