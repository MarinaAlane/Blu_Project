require_relative "../helpers/crawler_helper.rb"

class SuppliersController < ApplicationController
  def index
    @crawler_service = CrawlerService.new
    result = @crawler_service.fetch_data(CrawlerHelper::SUPPLIERS)

    categories_list = []
    @categories = result["suppliers"]

    @categories.each do |category|
      categories_list << { name: category["name"], id: category["id"] }
    end

    render json: categories_list
  end
end
