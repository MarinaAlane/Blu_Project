Rails.application.routes.draw do
  get "/crawler", to: "crawler#index"
  get "/suppliers", to: "suppliers#index"
  get "/estados", to: "country_state#index"
end
