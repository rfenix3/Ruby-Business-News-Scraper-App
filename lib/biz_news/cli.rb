# Our CLI controller

class BizNews::CLI
  
  def call
    list_headlines
    menu
    goodbye
  end
  
  def list_headlines
    puts "Today's Top 10 Business News from CNBC"
    @headlines = BizNews::Headline.today
    @headlines.each.with_index(1) {|headline, i|
      puts "#{i}. #{headline.title}"
    }
  end
  
  def menu
    input = nil
    while input != "exit"
      puts "Enter the NUMBER of the headline you like to read, LIST to refresh, or EXIT to end session."
      input = gets.strip.downcase

      if input == "list"
        list_headlines
      elsif input.to_i > 0
        if headline = BizNews::Headline.find(input.to_i)
          # puts "#{headline.url}"
          print_article(headline)
        end
      else
        puts 'Not sure what you want. Please type list, headline number, or exit.'
      end

    end
  end
  
  def print_article(headline)
    puts ""
    puts "====================================================================="
    puts "#{headline.title}"
    puts "Author: #{headline.author}"
    # puts "Email: #{headline.email}"
    puts "---------------------------------------------------------------------"
    puts "#{headline.article}"
    puts "====================================================================="

    # puts ""
  end
  
  def goodbye
    puts "See you tomorrow for more news!!!"
  end
end
