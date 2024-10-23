require_relative "../helpers/crawler_helper.rb"

class CrawlerController < ApplicationController
  def index
    @crawler_service = CrawlerService.new
    result = @crawler_service.fetch_data(CrawlerHelper::DEPARTMENTS)

    categories_list = []
    @categories = result["departments"]

    @categories.each do |category|
      categories_list << { name: category["name"], id: category["id"] }
    end

   render json: categories_list
  end
end
