class BizNews::Article
  attr_accessor :title, :author, :content 

  @@all = []

  def initialize(title = nil, author = nil, content = nil)
    @title = title
    @author = author
    @content = content
  end
  
  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_article(headline)
    all.detect{|s| s.title == headline.title}
  end
  
end
