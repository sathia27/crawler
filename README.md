This web crawler written in ruby. Nokogiri is used as scrapping tool. This code crawls all links from given url and save it in file.

## Prerequisite
* Ruby
* RubyGems
* Nokogiri

## Installation

### Nokogiri

```bash
gem install nokogiri
```

## How to run?

```bash
git clone https://github.com/sathia27/crawler.git
cd crawler
ruby bin/crawl.rb

Enter link to crawl: https://python.org

Allow external site to crawl? (y/n): n
Spider on https://python.org
You have already crawled this site. Do you want to continue? y/n: y
You can look in crawled links in data dir: data/python.org
```

## Check output

Once program terminates or you manually terminate program. You can get output from 

```bash
cd crawler/data
tail -f python.org
```



