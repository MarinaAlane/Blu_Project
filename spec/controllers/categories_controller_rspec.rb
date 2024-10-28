require 'rails_helper'

RSpec.describe "Categories API", type: :request do
  describe "GET /categorias" do
    let(:response_body) do
      {
        "departments" => [
          { "name" => "Categoria 1", "id" => 1 },
          { "name" => "Categoria 2", "id" => 2 }
        ]
      }.to_json
    end

    before do
       stub_request(:get, "https://repnota1000.blu.com.br/api/v1/departments").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Crawler'
           }).
         to_return(status: 200, body: response_body, headers: {})
    end

    it "retorna uma lista de categorias e as salva no banco de dados" do
      get "/categorias"

      expect(response).to have_http_status(:ok)
      categories_list = JSON.parse(response.body)

      expect(categories_list.size).to eq(2)

      category1 = Category.find_by(name_category: "Categoria 1")
      category2 = Category.find_by(name_category: "Categoria 2")

      expect(categories_list).not_to be_nil
    end
  end
end
