has_many: country_state

class Supplier < ApplicationRecord
  def self.create_supplier(suppliers)
    suppliers.each do |supplier_data|
      Supplier.find_or_create_by(
        id: supplier_data[:id],
        name_supplier: supplier_data[:name_supplier],
        category_id: supplier_data[:category_id],
        uf: supplier_data[:uf])
    end
  end
end
