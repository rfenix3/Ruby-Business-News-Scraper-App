# Our CLI controller responsible for business logic or user interaction
require 'date'

class BizNews::CLI

  def initialize
    @systemTime = Time.now.strftime("%m/%d/%Y %H:%M")
    @headline_max_no = 10   # this limits the number of headlines to be be displayed.
  end

  def call
    BizNews::Scraper.new.scrape_headlines
    list_headlines
    menu
    goodbye
  end
  
  def list_headlines
    puts "-------------------------------------------------------------------------------------------".colorize(:blue)
    puts "Today's Top 10 Business News from CNBC                    #{@systemTime}".colorize(:blue)
    puts "-------------------------------------------------------------------------------------------".colorize(:blue)
    @headlines = BizNews::Headline.all
    @headlines.first(@headline_max_no).each.with_index(1) {|headline, i|
      puts "#{i}. #{headline.title}"
    }
  end
  
  def menu
    input = nil
    while input != "exit"
      puts "-------------------------------------------------------------------------------------------".colorize(:blue)
      puts "Enter the NUMBER of the headline you like to read, LIST to refresh, or EXIT to end session.".colorize(:green)
      input = gets.strip.downcase

      if input == "list"
        list_headlines
      elsif input.to_i > 0 && input.to_i <= @headline_max_no
        if headline = BizNews::Headline.find(input.to_i)
          print_article(headline)
        end
      else
        if input != "exit"
          puts 'Not sure what you want. Please type list, headline number, or exit.'.colorize(:red)
        end
      end

    end
  end
  
  def print_article(headline)
    chosen_article = BizNews::Scraper.new.scrape_article(headline.title, headline.url)
  
    puts ""
    puts "====================================================================="
    puts "#{chosen_article.title}".colorize(:blue)
    puts "Author: #{chosen_article.author}                      #{@systemTime}"
    puts "---------------------------------------------------------------------"
    puts "#{chosen_article.content}".colorize(:blue)  

  end
  
  def goodbye
    puts "See you tomorrow for more news!!!"
  end
end
