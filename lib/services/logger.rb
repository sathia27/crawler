require 'json'
require 'open-uri'

module Logger
  
  def create_log
    # creates log file with url as file name
    Dir.mkdir("data") rescue false
    File.open(file_name, "w") if file_name
  end

  def file_exists?
    true if File.open(file_name) rescue false
  end

  def file_name
    "data/#{log_file}" if log_file
  end

  def open_logger_for_write
    File.open(file_name, 'w') if file_name
  end

  def can_create?
    log_file and !File.exists?(file_name)
  end

  def read index
    puts "Indexing #{index} of #{@results.uniq.count}"
    @results[index].strip rescue nil
  end
end
