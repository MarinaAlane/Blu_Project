require_relative "../helpers/crawler_helper.rb"

class SuppliersController < ApplicationController
  def index
    # definir o params dentro de um each de categories? e daí selecionar o suppliers dentro de cada um
    suppliers_url = CrawlerHelper::SUPPLIERS.call(params[:category] )
    @crawler_service = CrawlerService.new
    result = @crawler_service.fetch_data(suppliers_url)

    suppliers_list = []
    @suppliers = result["suppliers"]

    @suppliers.each do |supplier|
      department_id = supplier["department"]
      suppliers_list << { name: supplier["name"], id: supplier["id"], category_id: department_id }
    end

    render json: suppliers_list
  end
end
