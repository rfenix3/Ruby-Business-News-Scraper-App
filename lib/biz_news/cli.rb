# Our CLI controller responsible for business logic or user interaction
require 'date'

class BizNews::CLI

  def initialize
    @systemTime = Time.now.strftime("%m/%d/%Y %H:%M")
  end

  def call
    list_headlines
    menu
    goodbye
  end
  
  def list_headlines

    puts "Today's Top 10 Business News from CNBC                    #{@systemTime}"
    puts "-------------------------------------------------------------------------------------------"
    @headlines = BizNews::Headline.today
    @headlines.each.with_index(1) {|headline, i|
      puts "#{i}. #{headline.title}"
    }
  end
  
  def menu
    input = nil
    while input != "exit"
      puts "-------------------------------------------------------------------------------------------"
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
        if input != "exit"
          puts 'Not sure what you want. Please type list, headline number, or exit.'
        end
      end

    end
  end
  
  def print_article(headline)
    puts ""
    puts "====================================================================="
    puts "#{headline.title}"
    puts "Author: #{headline.author}                      #{@systemTime}"
    # puts "Email: #{headline.email}"
    puts "---------------------------------------------------------------------"
    puts "#{headline.article}"  #this calls the method 'article' from headline method

    # puts ""
  end
  
  def goodbye
    puts "See you tomorrow for more news!!!"
  end
end
