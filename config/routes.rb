Rails.application.routes.draw do
  get "/crawler", to: "crawler#index"
  get "/suppliers", to: "suppliers#index"
end
