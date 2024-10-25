require_relative "../helpers/crawler_helper.rb"

class CountryStateController < ApplicationController
  def index
    suppliers_url = CrawlerHelper::SUPPLIERS.call(params[:category])
    @crawler_service = CrawlerService.new
    result = @crawler_service.fetch_data(suppliers_url)

    country_list = []
    @suppliers = result["suppliers"]

    @suppliers.each do |supplier|
      uf = supplier["positions"]&.first

      states_name = uf && uf["name"].present? ? uf["name"] : "Sem informação de estado"
      uf = uf && uf["uf"].present? ? uf["uf"] : "Sem informação de estado"

      unless country_list.any? { |s| s[:name] == states_name }
        country_list << {
          name: states_name,
          uf: uf
        }
      end
    end

    CountryState.create_states(country_list)

    render json: country_list
  end
end
