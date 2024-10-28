FactoryBot.define do
  factory :category do
    sequence(:id) { |n| n }
    sequence(:name_category) { |n| "Categoria #{n}" }
  end
end
