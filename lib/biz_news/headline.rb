class BizNews::Headline
    attr_accessor :title, :url, :article, :author
  
  def initialize(title = nil, url = nil)
    @title = title
    @url = url
  end

  def self.all
    @@all ||= scrape_headlines
  end

  def self.find(id)
    self.all[id-1]
  end

  def self.today
    # return headlines from CNBC.com for today

    #scrape news site and then return headines 
    self.scrape_headlines
    # returns array of headlines(objects)...i.e., [headline_1, headline_2], to cli.rb
  
  end

  def article
    @article ||= get_article_doc.search("div#article_body p").text.strip
    # binding.pry
  end
  
  def author
    @author ||= get_author_doc.search("div.source a[itemprop='url']").text
  
    #binding.pry
    #author_name: @doc.search("div.source a[itemprop='url']").text  
    #author_email: @doc.search("div.source a").text
  end
  
  def email
    @email ||= get_author_doc.search("div.source a").text
  end

private

  def self.scrape_headlines
    
      headline_array = []
    
      doc = Nokogiri::HTML(open('http://www.cnbc.com'))
      @news = doc.css("div.headline")
      
      # Get the first 10 Headlines and push into an array
      (0..9).each do |n|
        headline_array.push(new(@news[n].text.strip, "https://www.cnbc.com#{@news.css("a")[n]["href"]}"))
      end

      headline_array
  end

  def get_article_doc
      @get_article ||= Nokogiri::HTML(open("#{self.url}"))
      # binding.pry
  end

  def get_author_doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end  

end
