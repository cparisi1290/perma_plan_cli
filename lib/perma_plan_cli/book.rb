class PermaPlanCli::Book
    attr_accessor :title, :author, :price, :url, :description, :availability

    @@all = [] 

    def initialize(title, author, price, url)
        @title = title
        @author = author
        @price = price
        @url = url
        self.save
    end
    
    def save
        @@all << self
        self
    end

    def self.all
        @@all
    end
end