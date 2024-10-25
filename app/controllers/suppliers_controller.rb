require_relative "../helpers/crawler_helper.rb"

class SuppliersController < ApplicationController
  def index
    suppliers_url = CrawlerHelper::SUPPLIERS.call(params[:category])
    @crawler_service = CrawlerService.new
    result = @crawler_service.fetch_data(suppliers_url)

    # VERIFICAR PAGINAÇÃO, QUANTOS SUPPLIERS VÃO APARECER, VÃO SER TODOS? COMO E QUANTO LIMITAR
    # PENSAR NA VELOCIDADE DO CARREGAMENTO
    suppliers_list = []
    @suppliers = result["suppliers"]

    @suppliers.each do |supplier|
      department = supplier["departments"]&.first
      department_id = department ? department["id"] : nil

      uf = supplier["positions"]&.first
      uf_names = uf && uf["name"].present? ? uf["name"] : "Sem informação de estado"

      suppliers_list << {
        name_supplier: supplier["name"],
        id: supplier["id"],
        category_id: department_id,
        uf: uf_names
      }
    end

    Supplier.create_supplier(suppliers_list)
    render json: suppliers_list
  end
end
