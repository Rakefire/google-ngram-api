class GoogleNgrams
  JSON_ARRAY_REGEX = /\[{.*}\];/


  def initialize(url_params)
    @url_params = url_params
  end

  def fetch
    dataAsObject
  end

  private

  attr_reader :url_params

  def agent
    @_agent ||= Mechanize.new
  end

  def page
    agent.get(GoogleNgramsUrlBuilder.new(url_params).url)
  end

  def dataNode
    page.search('script').find {|script| script.to_s.include? "var data = "}
  end

  def data
    JSON_ARRAY_REGEX.match(dataNode.to_s).to_s[0..-2]
  end

  def dataAsObject
    JSON.parse(data)
  end
end

class GoogleNgramsUrlBuilder
  GOOGLE_NGRAM_URL = 'https://books.google.com/ngrams/graph'

  def initialize(url_params)
    @url_params = url_params
  end

  def url
    "#{GOOGLE_NGRAM_URL}?content=#{content}&year_start=#{year_start}&year_end=#{year_end}&smoothing=#{smoothing}#{case_insensitivity}"
  end

  private

  attr_reader :url_params

  def content
    CGI.escape(contentArray.join(','))
  end

  def contentArray
    if url_params['content'].nil?
      ["Albert"]
    else
      CGI.unescape(url_params['content']).split(',')
    end
  end

  def year_start
    Integer(url_params.fetch('year_start', 1800))
  end

  def year_end
    Integer(url_params.fetch('year_end', 2000))
  end

  def smoothing
    Integer(url_params.fetch('smoothing', 3))
  end

  # if the api sees a 'case_insensitive' param it will be case insensitive
  def case_insensitivity
    if url_params['case_insensitive'] == "true"
      "&case_insensitive=on"
    else
      ""
    end
  end

end


