class CreateSuppliers < ActiveRecord::Migration[7.2]
  def change
    create_table :suppliers do |t|
      t.string :name_supplier
    end

    add_reference :suppliers, :category, foreign_key: true
  end
end
