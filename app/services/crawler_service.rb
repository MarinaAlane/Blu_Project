require "httparty"
require "json"

class CrawlerService
  include HTTParty
  base_uri CrawlerHelper::URL

  def initialize
    @options = { headers: { "User-Agent" => "Crawler" } }
  end

  def fetch_data(endpoint)
    response = self.class.get(endpoint, @options)

    if response.success?
      data = JSON.parse(response.body)
    end

    data
  end
end
