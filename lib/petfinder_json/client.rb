module PetfinderJSON
  module Client

    # Required: id       - integer - shelter ID
    def shelter(id)
      shelter = connect('/shelter.get', :id => id)
      Shelter.new(shelter['petfinder']['shelter'])
    end

    # Required: location - string  - postal code or city and state
    # Optional: count    - integer - how many to return, default is 25
    # Optional: name     - string  - full or partial shelter name
    # Optional: offset   - integer - offset into the result set, default is 0
    def find_shelters(location, params = {})
      all_shelters = []
      params = params.merge(:location => location)
      shelters = connect('/shelter.find', params)

      shelters['petfinder']['shelters']['shelter'].each do |shelter|
        all_shelters << Shelter.new(shelter)
      end
    end

    # Required: animal   - string  - pick from: barnyard, bird, cat, dog, 
    #                                  horse, pig, reptile, smallfurry
    # Required: breed    - string  - breed of animal (use breed.list for all)
    #                             api.petfinder.com/schemas/0.9/petfinder.xsd
    # Optional: count    - integer - how many to return, default is 25
    # Optional: offset   - integer - offset into the result set, default is 0
    def shelters_by_breed(animal_type, breed_type, params = {})
      all_shelters = []
      params = params.merge(:animal => animal_type, :breed => breed_type)
      shelters = connect('/shelter.listByBreed', params)

      shelters['petfinder']['shelters']['shelter'].each do |shelter|
        all_shelters << Shelter.new(shelter)
      end
    end

    def connect(method, params = {})
      params[:format] = PetfinderJSON::Configuration::DEFAULT_FORMAT 
      params[:key] = @api_key
      uri = URI(PetfinderJSON::Configuration::DEFAULT_ENDPOINT + method)
      uri.query = URI.encode_www_form(params)
      request = Net::HTTP.get(uri)
      response = JSON.parse(request)
    end
  end
end