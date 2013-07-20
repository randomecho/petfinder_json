module PetfinderJSON
  class Pet
    attr_reader :id, :age, :animal, :description, :last_update, :mix, 
      :name, :photos, :sex, :shelter_id, :shelter_pet_id, :size, :status,
      :breed, :contact, :media, :options
    
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
      when "options"
        val['option'].each do |option|
          @options << option['$t']
        end
      when "breeds"
        val['breed'].each do |breed|
          @breed << breed['$t']
        end
      end
    end
  end
end