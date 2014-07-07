module UrlParser

  def format links
    links.collect do |link|
      link = remove_fragment link
      unless link.nil? or link.eql?("")
        link = link.gsub(/\?(.*)|\/\?(.*)/, "")
        link = link[-1] == "/" ? link.chop : link
        link = full_url link
      end
    end
  end

  def pathname link
    link_uri = URI.parse(link) rescue false
    if external_sited_allow || link_uri.host.eql?(uri.host)
      link_uri.pathname
    end
  end

  def full_url link
    fu = nil
    if link.start_with?(host_name)
      fu = link
    elsif link.start_with?("/")
      fu = host_name + link
    end
  end

  def log_file
    return false if @url.nil?
    uri.host rescue false
  end
  
  def uri
    URI.parse(@url)
  end

  def external_sited_allow
    false
  end

  def url_scheme
    uri.scheme
  end
  
  def host_name
    url_scheme+"://"+log_file
  end

  def remove_fragment link
    link.split("#")[0] if link
  end
end
