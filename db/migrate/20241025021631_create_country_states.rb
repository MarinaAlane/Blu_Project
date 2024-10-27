class CreateCountryStates < ActiveRecord::Migration[7.2]
  def change
    create_table :country_states do |t|
      t.string :name_states
      t.string :uf
    end
  end
end
