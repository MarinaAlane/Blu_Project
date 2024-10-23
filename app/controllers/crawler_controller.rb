require_relative "../helpers/crawler_helper.rb"

class CrawlerController < ApplicationController
  def index
    @crawler_service = CrawlerService.new
    @suppliers = @crawler_service.fetch_data(CrawlerHelper::DEPARTMENTS)

    render json: @suppliers
  end
end
