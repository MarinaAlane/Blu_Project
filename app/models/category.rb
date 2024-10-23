require_relative "../services/crawler_service.rb"

class Category < ApplicationRecord
  def self.categories_list(categories)
    categories.each do |category_data|
      Category.find_or_create_by(id: category_data["id"], name_category: category_data["name"])
    end
  end
end
