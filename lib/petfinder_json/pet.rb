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
      when "media"
        @photos = extract_photos(val['photos']['photo'])
      end
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