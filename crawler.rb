require_relative 'lib/crawler/link'

class Crawler


  def initialize url, external_site=false
    @link = Link.new url, external_site
  end

  def exists?
    @link.exists?
  end

  def downloaded_path
    @link.file_name
  end

  def crawl
    @link.apply_spider
  end

end
