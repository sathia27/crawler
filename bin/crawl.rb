require_relative '../crawler'
print "Enter link to crawl: "
link = gets.chomp
puts
print "Allow external site to crawl? (y/n): "
external_site_crawled = gets.chomp.downcase
external_site_crawled = external_site_crawled.eql?("y") ? true : false
if link.nil?
  puts "Url cannot be blank"
else
  puts "Spider on #{link}"
  crawler = Crawler.new link, external_site_crawled
  already_exists = crawler.exists?
  if already_exists
    print "You have already crawled this site. Do you want to continue? y/n: "
    choice = gets.chomp.downcase
  end
  if choice.eql?('y') || !already_exists
    puts "You can look in crawled links in data dir: #{crawler.downloaded_path}"
    puts crawler.crawl
  end
end
