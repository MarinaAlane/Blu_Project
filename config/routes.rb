Rails.application.routes.draw do
  get "/crawler", to: "crawler#index"
end
