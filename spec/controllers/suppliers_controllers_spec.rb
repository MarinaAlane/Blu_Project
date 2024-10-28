require 'rails_helper'

RSpec.describe SuppliersController, type: :controller do
  let(:response_body) { "[]" }
  let(:suppliers_data) { [ { name_supplier: "Fornecedor A", id: 1, category_id: 10, uf: "São Paulo" }, { name_supplier: "Fornecedor B", id: 2, category_id: 20, uf: "Acre" } ] }

  before do
    @category_10 = create(:category, id: 10, name_category: "Categoria 10")
    @category_20 = create(:category, id: 20, name_category: "Categoria 20")

    create(:supplier, name_supplier: "Fornecedor A", id: 1, category: @category_10, uf: "São Paulo")
    create(:supplier, name_supplier: "Fornecedor B", id: 2, category: @category_20, uf: "Acre")

    allow_any_instance_of(CrawlerService).to receive(:fetch_data).and_return(suppliers_data)
  end

  describe "GET #index" do
    before do
      stub_request(:get, "http://127.0.0.1:3000/fornecedores")
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Crawler' })
        .to_return(status: 200, body: response_body, headers: {})
    end

    it "retorna uma lista de fornecedores e salva no banco de dados" do
      expect {
        get :index
      }.to change(Supplier, :count).by(2)

      suppliers_list = JSON.parse(response.body)
      expect(suppliers_list.size).to eq(2)
      expect(suppliers_list).to contain_exactly(
        hash_including("name_supplier" => "Fornecedor A", "id" => 1, "category_id" => 10, "uf" => "São Paulo"),
        hash_including("name_supplier" => "Fornecedor B", "id" => 2, "category_id" => 20, "uf" => "Acre")
      )
    end
  end

  describe "GET #search by category_id" do
    before do
      stub_request(:get, "http://127.0.0.1:3000/busca?category=")
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Crawler' })
        .to_return(status: 200, body: response_body, headers: {})
    end

    it "retorna fornecedores da categoria especificada" do
      get :search, params: { category: "10" }

      suppliers = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(suppliers.size).to eq(1)
      expect(suppliers.first).to include("name_supplier" => "Fornecedor A", "category_id" => 10, "uf" => "São Paulo")
    end
  end

  describe "GET #search by state_name" do
    before do
      stub_request(:get, "http://127.0.0.1:3000/busca?uf=")
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Crawler' })
        .to_return(status: 200, body: response_body, headers: {})
    end

    it "retorna fornecedores pelo estado especificado" do
      get :search, params: { uf: "São Paulo" }

      suppliers = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(suppliers.size).to eq(1)
      expect(suppliers.first).to include("name_supplier" => "Fornecedor A", "category_id" => 10, "uf" => "São Paulo")
    end
  end

  describe "GET #search by supplier_name" do
    before do
      stub_request(:get, "http://127.0.0.1:3000/busca?name=")
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Crawler' })
        .to_return(status: 200, body: response_body, headers: {})
    end

    it "retorna fornecedores pelo nome especificado" do
      get :search, params: { name: "Fornecedor A" }

      suppliers = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(suppliers.size).to eq(1)
      expect(suppliers.first).to include("name_supplier" => "Fornecedor A", "category_id" => 10, "uf" => "São Paulo")
    end
  end
end
