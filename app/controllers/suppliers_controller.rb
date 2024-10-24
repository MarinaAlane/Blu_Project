require_relative "../helpers/crawler_helper.rb"

class SuppliersController < ApplicationController
  def index
    suppliers_url = CrawlerHelper::SUPPLIERS.call(params[:category])
    @crawler_service = CrawlerService.new
    result = @crawler_service.fetch_data(suppliers_url)

    suppliers_list = []
    @suppliers = result["suppliers"]

    @suppliers.each do |supplier|
      department = supplier["departments"].first
      department_id = department["id"]
      department_name = department["name"]

      suppliers_list << { 
        name: supplier["name"], 
        id: supplier["id"], 
        department_id: department_id, 
        department_name: department_name 
      }
    end

    render json: suppliers_list
  end
end
