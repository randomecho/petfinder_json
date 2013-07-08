module PetfinderJSON
  class Breeds
    attr_reader :breeds_list

    def initialize(data)
      @breeds_list = []

      # Grabs list of breed types returned, placing them into an array
      data.each do |breed|
        if breed['$t'].is_a? String
          @breeds_list << breed['$t']
        end
      end
    end
    
  end
end