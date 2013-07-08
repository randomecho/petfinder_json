module PetfinderJSON
  class Shelter
    attr_reader :id, :address1, :address2, :city, :country, :email, :fax,
    :latitude, :longitude, :name, :phone, :state, :zip
    
    def initialize(data)
      data.each do |key, val|
        if key.is_a? String
          instance_variable_set("@" + key, val['$t'])
        end
      end
    end
    
  end
end