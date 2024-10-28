FactoryBot.define do
  factory :supplier do
    sequence(:id)
    name_supplier { "Fornecedor #{id}" }
    association :category
    uf { "São Paulo" }
  end
end
