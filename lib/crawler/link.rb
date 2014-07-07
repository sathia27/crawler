require 'nokogiri'
require 'open-uri'
require_relative '../services/logger'

class Link
  
  include Logger 
  
  def initialize url
    @url = url
    @link_pointer = 0
    @results = []
    @logger_file = nil
  end

  def page_links url
    page = Nokogiri::HTML(open(url)) rescue false
    page.search("a").collect { |link| link.attr("href") } if page
  end

  def exists?
    file_exists?
  end

  def remove_existing_links_from links
    links - @results
  end

  def apply_spider
    @logger_file = create_log
    while true
      begin
        url = find(@link_pointer) || @url
        break unless url
        links = page_links(url)
        format_and_save(links)
      rescue Interrupt
        puts 'Quitting.'
        break
      rescue => e
        puts e
        @link_pointer += 1
      end
    end
  end


  def format_and_save links
    if links
      links = format(links).compact.uniq
      links = remove_existing_links_from(links)
      @results += links
      @logger_file.write(links.join("\n"))
    end
    @link_pointer += 1
  end
end
