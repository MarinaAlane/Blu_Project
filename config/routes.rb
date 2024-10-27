Rails.application.routes.draw do
  get "/index", to: "categories#index"
  get "/fornecedores", to: "suppliers#index"
  get "/estados", to: "country_state#index"
  get "/busca", to: "suppliers#search"
end
