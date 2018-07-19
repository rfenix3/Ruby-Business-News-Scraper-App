class BizNews::Article
  attr_accessor :title, :author, :content 

  def initialize(title = nil, author = nil, content = nil)
    @title = title
    @author = author
    @content = content
  end
  
end
