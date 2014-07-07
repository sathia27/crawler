require_relative '../crawler'
print "Enter link to crawl: "
link = gets.chomp
if link.nil?
  puts "Url cannot be blank"
else
  puts "Spider on #{link}"
  crawler = Crawler.new link
  already_exists = crawler.exists?
  if already_exists
    print "You have already crawled this site. Do you want to continue? y/n: "
    choice = gets.chomp
  end
  puts already_exists.inspect
  puts crawler.crawl if choice.eql?('y') || !already_exists
end
