require 'rails_helper'

RSpec.describe CountryStateController, type: :controller do
  describe "GET /estados" do
    let(:suppliers_data) do
      {
        "suppliers" => [
          { "positions" => [ { "name" => "São Paulo", "uf" => "SP" } ] },
          { "positions" => [ { "name" => "Rio de Janeiro", "uf" => "RJ" } ] },
          { "positions" => [ { "name" => "Minas Gerais", "uf" => "MG" } ] }
        ]
      }
    end

    let(:response_body) { suppliers_data.to_json }

    before do
      stub_request(:get, "http://127.0.0.1:3000/estados")
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Crawler'
          }
        ).to_return(status: 200, body: response_body, headers: {})
    end

    context "when suppliers data is returned successfully" do
      before do
        allow_any_instance_of(CrawlerService).to receive(:fetch_data).and_return(suppliers_data)
      end

      it "does return a list of states" do
        get :index

        expect(response).to have_http_status(:ok)
        country_list = JSON.parse(response.body)

        expect(country_list.size).to eq(3)
        expect(country_list).to include(
          { "name" => "São Paulo", "uf" => "SP" },
          { "name" => "Rio de Janeiro", "uf" => "RJ" },
          { "name" => "Minas Gerais", "uf" => "MG" }
        )
      end

      it "does save the states to the database" do
        expect {
          get :index
        }.to change(CountryState, :count).by(3)

        expect(CountryState.find_by(name_states: "São Paulo", uf: "SP")).not_to be_nil
        expect(CountryState.find_by(name_states: "Rio de Janeiro", uf: "RJ")).not_to be_nil
        expect(CountryState.find_by(name_states: "Minas Gerais", uf: "MG")).not_to be_nil
      end
    end

    context "when suppliers data has missing state information" do
      let(:suppliers_data_with_missing_state) do
        {
          "suppliers" => [
            { "positions" => [ { "name" => "", "uf" => nil } ] }
          ]
        }
      end

      before do
        allow_any_instance_of(CrawlerService).to receive(:fetch_data).and_return(suppliers_data_with_missing_state)
      end

      it "does return 'No state information' when the name or uf is missing" do
        get :index

        expect(response).to have_http_status(:ok)
        country_list = JSON.parse(response.body)

        expect(country_list.size).to eq(1)
        expect(country_list).to include(
          { "name" => "Sem informação de estado", "uf" => "Sem informação de estado" }
        )
      end
    end
  end
end
