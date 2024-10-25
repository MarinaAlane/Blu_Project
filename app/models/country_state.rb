class CountryState < ApplicationRecord
  def self.create_states(states_list)
    puts states_list
    states_list.each do |states_data|
      CountryState.find_or_create_by(
        id: states_data[:id],
        name_states: states_data[:name],
        uf: states_data[:uf])
    end
  end

  def self.get_uf
    CountryState.select(:uf)
  end
end
