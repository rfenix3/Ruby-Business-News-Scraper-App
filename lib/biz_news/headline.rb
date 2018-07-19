class BizNews::Headline
  attr_accessor :title, :url 

  @@all = []
  
  def initialize(title = nil, url = nil)
    @title = title
    @url = url
  end
  
  def save
    @@all << self
  end

  def self.all
    @@all
  end
  
  def self.find(id)
    self.all[id-1]
  end

end
