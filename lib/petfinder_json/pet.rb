module PetfinderJSON
  class Pet
    attr_reader :id, :age, :animal, :description, :last_update, :mix, 
      :name, :photos, :sex, :shelter_id, :shelter_pet_id, :size, :status,
      :email, :phone, :fax, :address1, :address2, :city, :state, :zip,
      :breed, :media, :options
    
    def initialize(data)
      @options = []
      @breed = []

      data.each do |key, val|
        if key.is_a? String
          if val['$t'].is_a? NilClass
            self.multi_val(key, val)
          else
            instance_variable_set("@" + key, val['$t'])
          end
        end
      end
    end
    
    def multi_val(key, val)
      case key
      when "breeds"
        if val['breed'].count > 1
          val['breed'].each do |breed_type|
            @breed << breed_type['$t']
          end
        else
          @breed << val['breed']['$t']
        end
      when "contact"
        val.each do |info|
          instance_variable_set("@" + info[0], info[1]['$t'])
        end
      when "options"
        if val['option']
          if val['option'].count > 1
            val['option'].each do |option|
              @options << option['$t']
            end
          else
            @options << val['option']['$t']
          end
        end
      end
    end
  end
end