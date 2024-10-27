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

  def search
    if params[:uf].present?
      search_by_state_name
    elsif params[:category].present?
      search_by_category_id
    elsif params[:name].present?
      search_by_supplier_name
    else
      render json: { error: "Por favor, forneça um id de uma categoria ou o nome de um estado para a busca" }, status: :bad_request
    end
end

private
  def search_by_state_name
   uf = params[:uf].downcase.gsub(/\s+/, "")

  suppliers = Supplier.where("unaccent(LOWER(REPLACE(uf, ' ', ''))
    ) = unaccent(LOWER(REPLACE(?, ' ', '')))", uf)

  render json: suppliers.any? ? suppliers : { error: "Nenhum fornecedor encontrado para o estado especificado" },
    status: suppliers.any? ? :ok : :not_found
  end

  def search_by_category_id
    category_id = params[:category]

    suppliers = Supplier.where(category_id: category_id)

    render json: suppliers.any? ? suppliers : { error: "Nenhum fornecedor encontrado para a categoria especificada" },
      status: suppliers.any? ? :ok : :not_found
  end
  
  def search_by_supplier_name
    name = params[:name]

  suppliers = Supplier.where("LOWER(name_supplier) LIKE ?", "%#{name.downcase}%")
    render json: suppliers.any? ? suppliers : { error: "Nenhum fornecedor encontrado para a categoria especificada" },
      status: suppliers.any? ? :ok : :not_found
  end
end
