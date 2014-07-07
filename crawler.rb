require_relative 'lib/crawler/link'

class Crawler


  def initialize url
    @link = Link.new url
  end

  def exists?
    @link.exists?
  end

  def crawl
    @link.apply_spider
  end

end
