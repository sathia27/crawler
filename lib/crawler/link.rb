require 'nokogiri'
require 'open-uri'
require_relative '../services/logger'
require_relative '../services/url_helper'

class Link

  include Logger
  include UrlHelper

  def initialize url, external_site_allowed
    @url = url
    @external_site_allowed = external_site_allowed
    @log_line_pointer = 0
    @results = []
    @logger_file = nil
  end

  def page_links url
    @url = url
    page = Nokogiri::HTML(open(url)) rescue false
    page.search("a").collect { |link| link.attr("href") } if page
  end

  def exists?
    file_exists?
  end

  def remove_existing_links_from links
    links - @results
  end

  def external_site_allowed?
    @external_site_allowed
  end

  def apply_spider
    @logger_file = create_log
    while true
      begin
        url = @log_line_pointer.eql?(0) ? @url : read(@log_line_pointer)
        break unless url
        links = page_links(url)
        format_and_save(links)
      rescue Interrupt
        puts 'Quitting.'
        break
      rescue => e
        puts e
        @log_line_pointer += 1
        @logger_file.close if @logger_file
      end
    end
    @logger_file.close if @logger_file
  end


  def format_and_save links
    if links
      links = format(links).compact.uniq
      links = remove_existing_links_from(links)
      @results += links
      @logger_file.write(links.join("\n"))
    end
    @log_line_pointer += 1
  end
end
