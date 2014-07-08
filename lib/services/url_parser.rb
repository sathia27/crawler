module UrlParser

  def format links
    links.map do |link|
      link = remove_fragment link
      unless link.nil? or link.eql?("")
        link = remove_query_string(link)
        link = whitelist link if link
      end
    end
  end

  def remove_query_string link
    link[-1] == "/" ? link.chop : link
    link.gsub(/\?(.*)|\/\?(.*)/, "")
  end


  def whitelist link
    return unless link.scan(/mailto:|tel:/).empty?
    if link.start_with?(host_name)
      link
    else
      validate_url_without_hostname(link)
    end
  end

  def validate_url_without_hostname link
    if external_url?(link)
      link if external_site_allowed?
    else
      link.start_with?("/") ? host_name+link : host_name+"/"+link
    end
  end

  def pathname link
    link_uri = URI.parse(link) rescue false
    if external_sited_allow || link_uri.host.eql?(uri.host)
      link_uri.pathname
    end
  end

  def log_file
    return false if @url.nil?
    uri.host rescue false
  end
  
  def uri
    URI.parse(@url)
  end

  def external_url? link
    !link.scan(/http:|https:/).empty? && link.scan(/#{log_file}/).empty?
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
