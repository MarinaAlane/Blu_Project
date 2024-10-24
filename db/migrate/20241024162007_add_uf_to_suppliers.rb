class AddUfToSuppliers < ActiveRecord::Migration[7.2]
  def change
    add_column :suppliers, :uf, :string
  end
end
