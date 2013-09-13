module PetfinderJSON
  class Pet
    attr_reader :id, :age, :animal, :description, :last_update, :mix, 
      :name, :photos, :sex, :shelter_id, :shelter_pet_id, :size, :status,
      :email, :phone, :fax, :address1, :address2, :city, :state, :zip,
      :breed, :options, :photos
    
    def initialize(data)
      @breed = []
      @options = []

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
        @breed = extract_breeds(val['breed'])
      when "contact"
        val.each do |info|
          instance_variable_set("@" + info[0], info[1]['$t'])
        end
      when "options"
        @options = extract_options(val['option'])
      when "media"
        @photos = extract_photos(val['photos']['photo'])
      end
    end
    
    def extract_breeds(breed_data)
      breed_info = Array.new()
      
      if breed_data.count > 1
        breed_data.each do |breed_type|
          breed_info << breed_type['$t']
        end
      else
        breed_info << breed_data['$t']
      end
      
      return breed_info
    end
    
    def extract_options(option_data)
      option_info = Array.new()

      if option_data
        if option_data.count > 1
          option_data.each do |option|
            option_info << option['$t']
          end
        else
          option_info << option_data['$t']
        end
      end
      
      return option_info
    end
    
    def extract_photos(photo_data)
      photo_info = Array.new()

      photo_data.each do |photo|
        i = photo['@id'].to_i - 1
        photo_info[i] ||= Hash.new

        case photo['@size']
        when 'fpm'
          photo_info[i][:fpm] ||= photo['$t']
          photo_info[i][:featured] ||= photo['$t']
        when 'pn'
          photo_info[i][:pn] ||= photo['$t']
          photo_info[i][:petnote] ||= photo['$t']
        when 'pnt'
          photo_info[i][:pnt] ||= photo['$t']
          photo_info[i][:petnote_thumbnail] ||= photo['$t']
        when 't'
          photo_info[i][:t] ||= photo['$t']
          photo_info[i][:thumbnail] ||= photo['$t']
        when 'x'
          photo_info[i][:x] ||= photo['$t']
          photo_info[i][:large] ||= photo['$t']
        end
      end

      return photo_info
    end
   
  end
end